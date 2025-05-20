package shoppingmall.service.goods;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import shoppingmall.command.GoodsCommand;
import shoppingmall.domain.AuthInfoDTO;
import shoppingmall.domain.GoodsDTO;
import shoppingmall.repository.GoodsRepository;

@Service
public class GoodsWriteService {

    GoodsRepository goodsRepository;

    public GoodsWriteService(GoodsRepository goodsRepository) {
        this.goodsRepository = goodsRepository;
    }

    public void execute(
        GoodsCommand goodsCommand,
        MultipartFile mainImage,
        MultipartFile image1,
        MultipartFile image2,
        MultipartFile image3,
        HttpServletRequest request,
        HttpSession session
    ) {
    	String realPath = request.getServletContext().getRealPath("goods/upload");
    	System.out.println("realPath = " + realPath);
        File fileDir = new File(realPath);
        if (!fileDir.exists()) fileDir.mkdirs();

        try {
            // 메인이미지 저장
            String mainOriginal = mainImage.getOriginalFilename();
            String mainStore = UUID.randomUUID().toString().replace("-", "") + "_" + mainOriginal;
            File saveMain = new File(realPath, mainStore);
            mainImage.transferTo(saveMain);

            // 상세이미지 저장
            String[] originalNames = new String[3];
            String[] storeNames = new String[3];
            MultipartFile[] images = {image1, image2, image3};

            for (int i = 0; i < images.length; i++) {
                if (!images[i].isEmpty()) {
                    originalNames[i] = images[i].getOriginalFilename();
                    storeNames[i] = UUID.randomUUID().toString().replace("-", "") + "_" + originalNames[i];
                    images[i].transferTo(new File(realPath, storeNames[i]));
                }
            }

            String goodsDetailImage = String.join("`", originalNames);
            String goodsDetailStoreImage = String.join("`", storeNames);

            // 세션에서 사원 정보 추출
            AuthInfoDTO auth = (AuthInfoDTO) session.getAttribute("auth");

            // DTO 설정
            GoodsDTO dto = new GoodsDTO();
            dto.setGoodsNum(goodsCommand.getGoodsNum());
            dto.setGoodsName(goodsCommand.getGoodsName());
            dto.setGoodsPrice(goodsCommand.getGoodsPrice());
            dto.setGoodsContents(goodsCommand.getGoodsContents());
            dto.setEmpNum(auth.getUserId()); // 사원 ID
            dto.setGoodsMainImage(mainOriginal);
            dto.setGoodsMainStoreImage(mainStore);
            dto.setGoodsDetailImage(goodsDetailImage);
            dto.setGoodsDetailStoreImage(goodsDetailStoreImage);

            goodsRepository.goodsInsert(dto);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
