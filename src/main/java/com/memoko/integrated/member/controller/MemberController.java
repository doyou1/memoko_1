package com.memoko.integrated.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.memoko.integrated.member.dao.MemberDAO;
import com.memoko.integrated.member.vo.MemberVO;
import com.memoko.integrated.socialapi.service.KakaoLogin;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	  @Autowired
	   private MemberDAO dao;
	   
	   @RequestMapping(value="/join", method=RequestMethod.POST)
	   public String join(MemberVO member, HttpSession session) {
	      System.out.println(member);
		   
		   int cnt = dao.insertMember(member);
	      if(cnt > 0) {
	         System.out.println("가입 성공");
	      }
	      else {
	         System.out.println("가입 실패");
	      }
	      
	      //회원가입후 바로 로그인
	      session.setAttribute("userId", member.getMember_id());
	      session.setAttribute("nickName", member.getMember_nickname());
	      return "redirect:/";
	   }
	   
	   @RequestMapping(value="/logout",method=RequestMethod.GET)
	   public String logout(HttpSession session) {
	      String access_Token = (String) session.getAttribute("kakao_Access_Token");
	       if(access_Token != null) {
	          KakaoLogin.kakaoLogout(access_Token);          
	       }

	       	session.removeAttribute("userId");
	        session.removeAttribute("access_Token");
	        session.removeAttribute("login_type");
	        session.removeAttribute("nickName");
	       return "redirect:/";
	   }
	   
	   @RequestMapping(value="/login",method=RequestMethod.POST)
	   @ResponseBody
	   public int login(String login_id, String login_pw,HttpSession session) {
	      System.out.println(login_id);
	      System.out.println(login_pw);
		  MemberVO member = dao.memberSelectOne(login_id);
		  int result = 0;
		  
		  if(member != null) {
			  if(member.getMember_pw().equalsIgnoreCase(login_pw)) {
				  result = 1;
				  System.out.println("로그인 성공");
				  session.setAttribute("userId", member.getMember_id());
				  session.setAttribute("nickName", member.getMember_nickname());
			      session.setAttribute("login_Type", "default");
			  }else {//비밀번호 틀림
				  result = 3;
				  System.out.println("비밀번호 틀림");
			  }
		  } else {//아이디 틀림
			  System.out.println("아이디 틀림");
			  result = 2;
		  }

	      //return 1 : 로그인 성공, 2 : 아이디 틀림, 3 : 비밀번호 틀림
	      return result;
	   }

	   
	   @RequestMapping(value="/myPage", method=RequestMethod.GET)
	   public String updateMember(HttpSession session, Model model) {
	      String userId = (String)session.getAttribute("userId");
	      MemberVO member = dao.memberSelectOne(userId);
	      model.addAttribute("member", member);
	      return "/member/myPage";
	   }

	   
	   @RequestMapping(value="/idCheck", method=RequestMethod.POST)
	   @ResponseBody
	   public int idCheck(String member_id, Model model, HttpSession session) {
	      System.out.println("ID 중복확인 시작");
	      MemberVO member = dao.memberSelectOne(member_id);

	      //id중복확인
	      //select 후 아이디가 있으면 
	      int check = 0;
	      if(member != null) {
	         check = 1;
	      }

	      return check;
	      
	   }
	
	
}
