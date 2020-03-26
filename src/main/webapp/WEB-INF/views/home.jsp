<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!DOCTYPE html>
<html>
<head>
	<title>Home</title>
	
	<script src="/resources/js/jquery-3.4.1.min.js"></script>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" >
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
	<script src="/resources/js/bootstrap.min.js"></script>
	<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
	<style type="text/css">
	body { padding-top: 90px; }
​
	    .navbar-brand img{
	      width: 80%;
	    }
​
	    img.memocoChang{
	      padding-top: 40px;
	      padding-left: 40px;
	    }
​
	    img.balloon1{
	      width: auto;
	    }
​
	
		
		.join{
			position: absolute;
			width: 165px;
			height: 28px;
			left: 904px;
			top: 51px;
			text-decoration:none;
			font-family: Roboto;
			font-style: normal;
			font-weight: normal;
			font-size: 36px;
			line-height: 42px;
			color: #000000;
		}
		
		.login{
			position: absolute;
			width: 109px;
			height: 33px;
			left: 1053px;
			top: 51px;
			text-decoration:none;
			font-family: Roboto;
			font-style: normal;
			font-weight: normal;
			font-size: 36px;
			line-height: 42px;
​
			color: #000000;
		}
		
		.img1{
         position: absolute;
         width: 660px;
         height: 435px;
         left: 80;
         top: 240px;
​
         
      }
      
      .img2{
         position: absolute;
         width: 660px;
         height: 435px;
         left: 800px;
         top: 240px;
         
​
      }
      .modal-body{
         text-align: center;
      }		
	</style>
</head>
<body>
   <!-- Navigation -->
  <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top" id="mainNav">
    <div class="container-fluid">
      <a class="navbar-brand js-scroll-trigger" href="/"> <!-- 메모코 로고 -->
 		<img alt="MEMOCO" src='<c:url value="/resources/css/memoco_logo.png" />'>
      </a>
     <!-- Toggler/collapsibe Button -->
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
       <span class="navbar-toggler-icon"></span>
      </button>
	 <div class="collapse navbar-collapse" id="navbarResponsive">
        <ul class="navbar-nav ml-auto">
        <c:choose>
         <c:when test="${sessionScope.userId != null }">
         <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="/board/boardList">게시판 글</a>
          </li>
          <li class="nav-item">
         <c:if test="${sessionScope.login_Type eq 'google'}">
               <a class="nav-link js-scroll-trigger" href="javascript:googleLogout()">로그아웃</a>
            </c:if>
            <c:if test="${sessionScope.login_Type eq 'kakao'}">
               <a class="nav-link js-scroll-trigger" href="javascript:kakaoLogout()">로그아웃</a>
            </c:if>
            <c:if test="${sessionScope.login_Type eq 'naver'}">
               <a class="nav-link js-scroll-trigger" href="javascript:naverLogout()">로그아웃</a>
            </c:if>
			<c:if test="${sessionScope.login_Type eq 'default'}">
            	<a class="nav-link js-scroll-trigger" href="/member/logout">로그아웃</a>
            </c:if>
          </li>            
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="/member/myPage">마이페이지</a>
          </li>
         </c:when>
         <c:otherwise>
         <li class="nav-item">
             <a class="nav-link js-scroll-trigger joinBtn" href="/member/joinForm" data-toggle="modal" data-target="#joinModal">회원가입</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger loginBtn" href="/member/loginForm" data-toggle="modal" data-target="#loginModal">로그인</a>
          </li>
            </c:otherwise>
      </c:choose>      
        </ul>
      </div>
    </div>
  </nav>

 
   <!-- 회원가입 -->
   <!-- Modal -->
 <div class="modal fade" id="joinModal" tabindex="-1" role="dialog" aria-labelledby="joinModalLabel" aria-hidden="true">
   <div class="modal-dialog" role="document">
       <div class="modal-content">
         <div class="modal-header">
           <h5 class="modal-title" id="joinModalLabel">회원가입</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close">
             <span aria-hidden="true">&times;</span>
           </button>
         </div>
         <div class="w3-center" id="joinCheck" class="modal-body">
          <form action="/member/join" method="post" onsubmit="return joinformCheck();">
          	<p>
           <input class="w3-input w3-border w3-margin-bottom" type="text" id="member_id" name="member_id" placeholder="중복확인  버튼을 클릭해주세요" required>
               <input type="button" value="아이디 중복확인" id="idCheck">
            </p>
            <div id="idCheckMsg"></div>
            <p>
               <a>비밀번호<input style="border: solid; color: green;" type="password" id="member_pw" name="member_pw" required></a>
            </p>
            <p>
               <a>비밀번호확인<input type="password" id="pwCheck" required></a>
            </p>
            <p>
               <a>회원 닉네임<input type="text" id="member_nickname" name="member_nickname" required></a>
            </p>
            <p>
               <a>회원 이메일<input type="text" id="member_email" name="member_email" size="30" required></a>
            </p>
            <p>
               <a>선호 음식</a>
               <input type="text" id="text" id="member_favorite" name="member_favorite">
            </p>

         <div class="modal-footer">
           <input type="submit" id="memberJoin" class="btn btn-secondary" value="Join">
           <button style="border: none; outline: none;" type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
         </div>
          </form> 
       </div>
     </div>
   </div>
</div>

  <!-- 로그인 -->
   <!-- Modal -->
<div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="loginModalLabel" aria-hidden="true">
   <div class="modal-dialog" role="document">
       <div class="modal-content">
         <div class="modal-header">
           <h5 class="modal-title" id="loginModalLabel">로그인</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close">
             <span aria-hidden="true">&times;</span>
           </button>
         </div>
         <div class="modal-body">
            <p>
				아이디<input type="text" id="login_id" name="member_id" required>
            </p>
            <p>
            	비밀번호<input type="password" id="login_pw" name="member_pw" required>
            </p>
			<p>
           <button style="border: none; outline: none;" type="button" id="memberLogin">Login</button>
           <button style="border: none; outline: none;" type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
         	</p>
           <p>
            <a href="javascript:googleLogin('${google_url}')">
               <img src="https://developers.google.com/identity/images/btn_google_signin_dark_normal_web.png?hl=ko">
             </a> 
         </p>
            <div>
         <p id="kakaoLogin">
             <a href="javascript:kakaoLogin('${kakao_url}')">
               <img src="/resources/img/kakao_account_login_btn_medium_narrow.png">
            </a>
         </p>
         <p>
             <a href="javascript:naverLogin('${naver_url}')">
               <img src="/resources/img/naver_login_btn_completed.PNG" width="222" height="49">
            </a>
         </p>
         </div>
         <div class="modal-footer">
         </div>
       </div>
     </div>
   </div>
</div>


<p>
<a href="/storage/uploadFileForm">/storage/uploadFileForm</a>
</p>
<p>
<a href="/recipe/insertRecipeForm">/recipe/insertRecipeForm</a>
</p>
<a href="/imageanalysis/uploadImageForm"><img class="img1" src="https://i.ytimg.com/vi/iPk145zzwws/maxresdefault.jpg"></a>
<a href=#><img class="img2" src="https://recipe1.ezmember.co.kr/cache/recipe/2018/07/18/57c42a50e86d8cd890ee47384d7707001.jpg"></a>

</body>

<script type='text/javascript'>

	var loginAjax = function(){
		$.ajax({
			url : "/member/login",
			type : "post",
			data : {"id": $("#login_id").val(),
					"pw" : $("#login_pw").val()
					},
			success : function(result){
				//로그인 완료
				if(result == 1){
					window.location.reload()
				} else if(result == 2){//아이디 틀림
					alert("아이디가 틀림")
				} else if(result == 3){
					alert("비밀번호가 틀림")
				}
			},error : function(){
				alert("error")
			}
		})
	}
	
	var loginCanEnter = false;
	//회원가입 A태그
	$("#joinModal").on("shown.bs.modal",function(){
		$("#member_id").focus();

	})
	 
	$("#loginModal").on("shown.bs.modal",function(){
		$("#login_id").focus();
		loginCanEnter = true;
	}) 
	
	$(document).keydown(function(event){
		
		if(event.keyCode == 13 && loginCanEnter){
			if($("#login_id").val() == "" || $("#login_id").val() == null){
				return;
			}else if($("#login_pw").val() == "" || $("#login_pw").val() == null){
				return;
			}

			loginAjax()
		}
	});

	$("#memberLogin").on("click",function(){
		if($("#login_id").val() == "" || $("#login_id").val() == null){
			return;
		}else if($("#login_pw").val() == "" || $("#login_pw").val() == null){
			return;
		}

		loginAjax()
	})
	
	
			
	//Google Login
	function googleLogin(url){
		window.location.href= url
	}
	//Kakao Login
	function kakaoLogin(url){
		window.location.href = url;
	}
	//Naver Login
	function naverLogin(url){
		window.location.href = url;
	}

	//Google Logout	
	function googleLogout(){
		var logout = window.open("https://accounts.google.com/logout")
		logout.close();
		location.href="/member/logout";
	}
	//Kakao Logout
	function kakaoLogout(){
		var logout = window.open("https://developers.kakao.com/logout");
		logout.close();
		location.href="/member/logout";
	} 

	//Naver Logout
	function naverLogout(){
		var logout = window.open("http://nid.naver.com/nidlogin.logout")
		logout.close();
		location.href="/member/logout";
	}
	

	//ID중복확인을 위한 val
	var check = false;
	//ID중복확인
	$("#idCheck").click(function(){	
		if($("#member_id").val() == "" || $("#member_id").val() == null){
			alert("ID값입력해야 중복확인가능")
			return false;
		} else if($("#member_id").val().length < 3){
			alert("ID는 3글자 이상")
		}

		$.ajax({
			url: "/member/idCheck",
		    type:"post",
		    data: {"member_id":$("#member_id").val()},
		    dataType:"json",
		    success: function(result){
		    	if(result == 1){
		        //회원가입 실패
		        	$("#idCheckMsg").html("중복된 아이디입니다 다시 입력하세요");
		        }else{
		        //회원가입 성공
		        	$("#idCheckMsg").html("입력한 아이디는 사용하실 수 있습니다")
		            check = true;
		        }
			},
		    error : function(){
		    	alert("error");
		    }
		})       
	})
	
/* 	//회원가입 유효성검사
	function joinformCheck(){
		var password = document.getElementById("member_pw");
		var checkPW = document.getElementById("pwCheck");
			
		//ID중복체크를 안했다면
		if(!check){
			alert("ID중복체크 미실시!")
			return false;
		}else if(password.value == ''  || password.value.length == 0){
			alert("비밀번호를 다시 입력하세요");
	        return false;
	    }else if(password.value != checkPW.value){
			alert("동일한 비밀번호를 입력하세요");
	        return false;
	    }
	    return true;
	} */

	
</script>
</html>
