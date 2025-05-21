package shoppingmall.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import shoppingmall.command.GoodsCommand;
import shoppingmall.service.goods.GoodsAutoNumService;
import shoppingmall.service.goods.GoodsDeleteService;
import shoppingmall.service.goods.GoodsDetailService;
import shoppingmall.service.goods.GoodsListService;
import shoppingmall.service.goods.GoodsUpdateService;
import shoppingmall.service.goods.GoodsWriteService;

@Controller
@RequestMapping("/goods")

public class GoodsController {
	
	@Autowired
	GoodsAutoNumService goodsAutoNumService;
	@Autowired
	GoodsWriteService goodsWriteService;
	@Autowired
	GoodsListService goodsListService;
	@Autowired
	GoodsDetailService goodsDetailService;
	@Autowired
	GoodsUpdateService goodsUpdateService;
	@Autowired
	GoodsDeleteService goodsDeleteService;
	
	
	@GetMapping("/goodsList")
	public String list(Model model) {
		goodsListService.execute(model);
		return "goods/goodsList";
	}
	
	@GetMapping("/goodsWrite")
	public String write(Model model) {
		goodsAutoNumService.execute(model);
		return "goods/goodsForm";
	}
	
    // 상품 등록 처리    
    @PostMapping("goodsWrite")
    public String Write(
        GoodsCommand goodsCommand,
        HttpSession session
    ) {
        goodsWriteService.execute(goodsCommand, session);
        return "redirect:/goods/goodsList";
    }
	
	@GetMapping("/goodsDetail")
	public String detail(HttpServletRequest request, Model model, String goodsNum) {
		goodsDetailService.execute(request, model, goodsNum);
		return "goods/goodsInfo";
	}
	
	@GetMapping("/goodsUpdate")
	public String update(HttpServletRequest request, Model model, String goodsNum) {
		goodsDetailService.execute(request, model, goodsNum);
		return "goods/goodsModify";
	}
	
	@PostMapping("/goodsModify")
	public String Update(GoodsCommand goodsCommand) {
	    goodsUpdateService.execute(goodsCommand);
		return "redirect:/goods/goodsDetail?goodsNum=" + goodsCommand.getGoodsNum();

	}
	
	@GetMapping("/goodsDelete")
	public String delete(String goodsNum) {
		goodsDeleteService.execute(goodsNum);
		return "redirect:/goods/goodsList";
	}
}
