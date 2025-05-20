package shoppingmall.controller;

import java.io.IOException;
import java.io.PrintWriter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import shoppingmall.command.LoginCommand;
import shoppingmall.domain.AuthInfoDTO;
import shoppingmall.repository.ItemRepository;
import shoppingmall.repository.MemberRepository;
import shoppingmall.service.FileDelService;
import shoppingmall.service.LoginService;
import shoppingmall.service.item.CartInsertService;
import shoppingmall.service.item.CartListService;
import shoppingmall.service.user.EmailCheckService;

@RestController
public class CheckRestController {

    @Autowired
    EmailCheckService emailCheckService;
    @Autowired
    FileDelService fileDelService;
    @Autowired
    LoginService loginService;
    @Autowired
    CartListService cartListService;
    @Autowired
    MemberRepository memberRepository;
    @Autowired
    ItemRepository itemRepository;
    @Autowired
    CartInsertService cartInsertService ;
    // 이메일 인증 처리
    @GetMapping("/help/userConfirm")
    public String confirm(String chk) {
        Integer i = emailCheckService.execute(chk);
        if (i != 0) return "인증되었습니다.";
        else return "이미 인증되었습니다.";
    }

    // 파일 삭제 처리
    @PostMapping("/file/fileDel")
    public int fileDel(String orgFile, String storeFile, HttpSession session) {
        return fileDelService.execute(orgFile, storeFile, session);
    }
   
    @PostMapping("/item/cart")
    public void cart(String goodsNum , int cartQty, HttpSession session) {
    	cartInsertService.execute(goodsNum, cartQty, session);
    }


}
