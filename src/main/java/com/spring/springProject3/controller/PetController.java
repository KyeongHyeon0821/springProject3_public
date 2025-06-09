package com.spring.springProject3.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.springProject3.service.PetService;
import com.spring.springProject3.vo.PetVo;

@Controller
@RequestMapping("/pet")
public class PetController {

    @Autowired
    PetService petService;

    // 강아지 등록 폼
    @GetMapping("/register")
    public String petRegisterGet() {
        return "pet/petRegister";
    }

    // 강아지 등록 처리
    @PostMapping("/register")
    public String petRegisterPost(PetVo vo, HttpSession session, Model model) {
    	
    	String memberMid = (String) session.getAttribute("sMid");
        vo.setMemberMid(memberMid);

        petService.insertPet(vo);
        
        List<PetVo> dogList = petService.getPetList(memberMid);
        model.addAttribute("dogList", dogList);
        
        return "redirect:/member/memberMyPage";
    }
    
    // 강아지 삭제 처리
    @GetMapping("/deletePet")
    public String petDelete(@RequestParam("petIdx") int petIdx) {
        PetVo vo = new PetVo();
        vo.setPetIdx(petIdx);
        petService.deletePet(vo);
        return "redirect:/member/memberMyPage";
    }

    // 강아지 리스트 보기 (마이페이지 내에서)
    @GetMapping("/list")
    public String petListGet(HttpSession session, Model model) {
        String memberMid = (String) session.getAttribute("sMid");
        List<PetVo> dogList = petService.getPetList(memberMid);
        model.addAttribute("dogList", dogList);
        return "pet/petList";
    }
    
    // 강아지 정보 수정 폼 보기
    @RequestMapping(value = "/update", method = RequestMethod.GET)
    public String petUpdateGet(@RequestParam("petIdx") int petIdx, Model model) {
        PetVo vo = petService.getPetById(petIdx); // DB에서 pet 정보 가져오기
        model.addAttribute("vo", vo);
        return "pet/petUpdate";
    }

    // 강아지 정보 수정 처리
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public String petUpdatePost(HttpSession session, PetVo vo, Model model) {
        String mid = (String) session.getAttribute("sMid");
        vo.setMemberMid(mid);

        int res = petService.updatePet(vo);
        model.addAttribute("vo", vo);

        if (res != 0) {
            model.addAttribute("result", "ok");
            model.addAttribute("name", vo.getPetName());
        } else {
            model.addAttribute("result", "no");
        }

        return "pet/petUpdate";
    }


}
