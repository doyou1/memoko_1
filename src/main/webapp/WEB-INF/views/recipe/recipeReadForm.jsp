<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" ></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" ></script>
	<script src="/resources/js/bootstrap.min.js"></script>
	<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
	<style>
		.carousel-item{
			width : 1156px;
			height : 580px;
		}
		
		.carousel-item img{
			position: absolute; top:0; left: 0;
			width: 100%;
			height: 100%;
		}
	</style>
	<style type="text/css">
	
		#mainNav{
			position: relative;
			width: 1440px;
			height: 140px;
			left: 0px;
			top: 0px;
		
			background: #D7F03C;
		}
		.memoco{
			position: absolute;
			width: 212px;
			height: 65px;
			left: 23px;
			top: 30px;
			text-decoration:none;
			font-family: Alegreya;
			font-style: normal;
			font-weight: normal;
			font-size: 48px;
			line-height: 65px;
			
			color: black;
		}
		.meci{
			position: absolute;
			width: 132px;
			height: 26px;
			left: 55px;
			top: 88px;
			text-decoration:none;
			font-family: Alegreya;
			font-style: normal;
			font-weight: normal;
			font-size: 14px;
			line-height: 19px;

			color: #000000;
		}
		
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

			color: #000000;
		}
		
      .modal-body{
         text-align: center;
      }
    img{
     	width : 500px;
		height : 500px;
	}
	#carousel-body{
		overflow: hidden;	
	}
	</style>
	<script>
		
	</script>
</head>
<body>
<!-- Navigation -->
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top" id="mainNav">
    <div class="container">
      <a class="navbar-brand js-scroll-trigger memoco" href="/">MEMOCO</a>
      <a class="navbar-brand js-scroll-trigger meci">飯を持ってくれる子</a>
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

          </li>				
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="/member/updateMember">회원 정보 수정</a>
          </li>				
			</c:when>
			<c:otherwise>
			<li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="/member/joinForm">회원가입</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="/member/loginForm" data-toggle="modal" data-target="#exampleModal">로그인</a>
          </li>
   			</c:otherwise>
		</c:choose>      
        </ul>
      </div>
    </div>
  </nav>
  
  <!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
   <div class="modal-dialog" role="document">
       <div class="modal-content">
         <div class="modal-header">
           <h5 class="modal-title" id="exampleModalLabel">로그인</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close">
             <span aria-hidden="true">&times;</span>
           </button>
         </div>
         <div class="modal-body">
            <p>
               <a>아이디<input type="text" id="member_id" name="member_id"></a>
            </p>
            <p>
               <a>비밀번호<input type="password" id="member_pw" name="member_pw"></a>
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
           <button style="border: none; outline: none;" type="button" id="memberLogin">Login</button>
           <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
         </div>
       </div>
     </div>
   </div>
</div>

<div class="container">
    <div class="row">
		<div class="col-8">
<div id="carousel" class="carousel slide" data-ride="carousel" data-interval="false">
  <ol class="carousel-indicators">
  	<c:forEach var="i" begin="0" end="${recipe.getListcontent().size()-1}">
  		<c:choose>
  			<c:when test="${i == 0}">
  				<li data-target="#carousel" data-slide-to="0" class="active"></li>
  			</c:when>
  			<c:otherwise>
  				<li data-target="#carousel" data-slide-to="${i}"></li>		
  			</c:otherwise>
  		</c:choose>
  	</c:forEach>
    
  </ol>
	
  <div class="carousel-inner" id="carousel-body">
    <c:forEach var="i" begin="0" end="${recipe.getListcontent().size()-1}">
    	<c:choose>
    		<c:when test="${i==0}">
			    <div class="carousel-item active">
			    	<img src="${recipe.getListphoto().get(i)}" alt="${i} slide">
			    	<div class="carousel-caption">   		
			    		<h5></h5>
			    		<p>${recipe.getListcontent().get(i)}</p>
			  		</div>
			    </div>
    		</c:when>
    		<c:otherwise>
    			<div class="carousel-item">
			    	<img src="${recipe.getListphoto().get(i)}" alt="${i} slide">
			    	<div class="carousel-caption">   		
			    		<h5></h5>
			    		<p>${recipe.getListcontent().get(i)}</p>
			  		</div>
			    </div>
    		</c:otherwise>
    	</c:choose>
    </c:forEach>
  </div>
  <a class="carousel-control-prev" href="#carousel" role="button" data-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="carousel-control-next" href="#carousel" role="button" data-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="sr-only">Next</span>
  </a>
</div>
		</div>
		<div class="col-4">
	<table border="1">
	<tr>
		<th>
			재료명
		</th>
		<th>
			재료양
		</th>
	</tr>
	<c:forEach var="i" begin="0" end="${recipe.getListingrd().size()-1}">
		<tr>
			<th>
				<p>
					${recipe.getListingrd().get(i)}
				</p>
			</th>
			<th>
				<p>
					${recipe.getListamount().get(i)}
				</p>
			</th>
		</tr>
	
	</c:forEach>
	</table>
			
		</div>
	</div>
</div>

</body>
<script>
$(document).keydown(function(event){
    var key = event.keyCode;
    var prev = $(".carousel-control-prev")
    var next = $(".carousel-control-next")
    if(key==37){
    //왼쪽
		prev.click()
    }else if(key==38){
    //위      
		prev.click()
    }else if(key==39){
    //오른쪽    
		next.click()
    }else if(key==40){
    //아래    
		next.click()
    }
});


</script>
<script type='text/javascript'>
	$('#myModal').on('shown.bs.modal', function () {
	  $('#myInput').trigger('focus')
	})

	function googleLogin(url){
		window.location.href= url
	}

	function kakaoLogin(url){
		window.location.href = url;
	}

	function naverLogin(url){
		window.location.href = url;
	}

	function kakaoLogout(){
		var logout = window.open("https://developers.kakao.com/logout");
		logout.close();
		location.href="/member/logout";
	} 

	
	function googleLogout(){
		var logout = window.open("https://accounts.google.com/logout")
		logout.close();
		location.href="/member/logout";
	}

	function naverLogout(){
		var logout = window.open("http://nid.naver.com/nidlogin.logout")
		logout.close();
		location.href="/member/logout";
	}
</script>
</html>