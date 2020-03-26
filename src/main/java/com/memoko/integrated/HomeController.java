package com.memoko.integrated;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.social.google.connect.GoogleOAuth2Template;
import org.springframework.social.oauth2.GrantType;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.memoko.integrated.member.dao.MemberDAO;
import com.memoko.integrated.member.vo.MemberVO;
import com.memoko.integrated.socialapi.service.NaverLogin;
import com.memoko.integrated.socialapi.vo.AuthInfo;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	@Inject
	private AuthInfo authInfo;
	   
	@Autowired
	private GoogleOAuth2Template googleOAuth2Template;
	    
	@Autowired
	private OAuth2Parameters googleOAuth2Parameters;
	
	@Autowired
	private MemberDAO dao;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model, HttpSession session) {
		
		String userId = (String) session.getAttribute("userId");
		
		if(userId != null && userId != "") {
			System.out.println(userId);
			MemberVO member = dao.memberSelectOne(userId);
			model.addAttribute("member", member);
		}
		//URL을 생성한다.
        String google_url = googleOAuth2Template.buildAuthenticateUrl(GrantType.AUTHORIZATION_CODE, googleOAuth2Parameters);
        String kakao_url = "https://kauth.kakao.com/oauth/authorize?client_id=b0dcf73a3623a9c86f877af826de50ad&redirect_uri=http://localhost:8888/socialapi/kakaoLogin&response_type=code";
    	String naver_url = NaverLogin.getAuthorizationUrl(session);
  
        session.setAttribute("google_url", google_url);
        session.setAttribute("kakao_url", kakao_url);
        session.setAttribute("naver_url", naver_url);
        
		return "home";
	}
	
}
