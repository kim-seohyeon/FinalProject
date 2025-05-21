package shoppingmall.service.goods;

import java.io.File;
import java.net.URL;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpSession;
import shoppingmall.command.GoodsCommand;
import shoppingmall.domain.AuthInfoDTO;
import shoppingmall.domain.GoodsDTO;
import shoppingmall.repository.GoodsRepository;

@Service
public class GoodsWriteService {
	@Autowired
    GoodsRepository goodsRepository;

    public void execute( GoodsCommand goodsCommand, HttpSession session) {
    	AuthInfoDTO auth = (AuthInfoDTO)session.getAttribute("auth");
    	GoodsDTO dto = new GoodsDTO();
        dto.setGoodsNum(goodsCommand.getGoodsNum());
        dto.setGoodsName(goodsCommand.getGoodsName());
        dto.setGoodsPrice(goodsCommand.getGoodsPrice());
        dto.setGoodsContents(goodsCommand.getGoodsContents());
        dto.setEmpNum(auth.getUserId()); // 사원 ID
        URL resource = getClass().getClassLoader().getResource("static/goodsUpload");
		String fileDir = resource.getFile();
		if(!goodsCommand.getGoodsFile().getOriginalFilename().isEmpty()) {
			MultipartFile mf = goodsCommand.getGoodsFile();
			// 원본 파일 이름
			String originalName = mf.getOriginalFilename();
			// 저장 파일 이름 만들기
			// 확장자 찾아오기 : ???.hwp
			String extension = originalName.substring(originalName.lastIndexOf("."));
			// 저장 이름 
			String storeName = UUID.randomUUID().toString().replace("-", "");
			// 확장자를 붙인 파일 이름
			String storeFileName = storeName + extension;
			// 저장 파일 생성
			File file = new File(fileDir + "/" +storeFileName);
			try {
				// 원본이름을 저장파일이름으로 변경하여 저장
				mf.transferTo(file);
			} catch (Exception e) {
				e.printStackTrace();
			}
			// dto저장
			dto.setGoodsMainImage(originalName);
			dto.setGoodsMainStoreImage(storeFileName);
		}
		if(!goodsCommand.getGoodsImageFile()[0].getOriginalFilename().isEmpty()) {
			String totalOriginalName = "";
			String totalStoreName = "";
			for(MultipartFile mf : goodsCommand.getGoodsImageFile()) {
				String originalName = mf.getOriginalFilename();
				String extension = originalName.substring(originalName.lastIndexOf("."));
				String storeName = UUID.randomUUID().toString().replace("-", "");
				String storeFileName = storeName + extension;
				File file = new File(fileDir + "/" +storeFileName);
				try {
					mf.transferTo(file);
				} catch (Exception e) {
					e.printStackTrace();
				}
				totalOriginalName += originalName + "`";
				totalStoreName += storeFileName + "`";
			}
			dto.setGoodsDetailImage(totalOriginalName);
			dto.setGoodsDetailStoreImage(totalStoreName);
		}
		goodsRepository.goodsInsert(dto);
		
		// 일반 파일
    }
}
