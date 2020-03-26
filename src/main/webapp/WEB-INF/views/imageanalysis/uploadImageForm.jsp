<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<html>
<head>
<title>uploadImageForm</title>
      <script src="/resources/js/jquery-3.4.1.min.js"></script>
      <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" 
      integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
      <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" 
      integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
      <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" 
      integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
      <script src="/resources/js/bootstrap.min.js"></script>
      <script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
</head>

   <style type="text/css">

      body { padding-top: 90px; }

       .navbar-brand img{
         width: 80%;
       }

       img.memocoChang{
         padding-top: 40px;
         padding-left: 40px;
       }

       img.balloon1{
         width: auto;
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
      
      .img1{
         position: absolute;
         width: 660px;
         height: 435px;
         left: 80;
         top: 240px;

         
      }
      
      .img2{
         position: absolute;
         width: 660px;
         height: 435px;
         left: 800px;
         top: 240px;
         

      }
      .modal-body{
         text-align: center;
      }
   </style>
   
   
<body>

   <!-- navbar 시작 -->
<nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top" id="mainNav">
	<div class="container-fluid">
		<a class="navbar-brand js-scroll-trigger" href="/"> <!-- 메모코 로고 -->
			<img alt="MEMOCO" src='<c:url value="/resources/css/memoco_logo.png" />'>
		</a>
    
      <!-- Toggler/collapsibe Button -->
      	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        	<span class="navbar-toggler-icon"></span>
      	</button>
      <!-- navbar-collapse 시작 -->
      
      	<div class="collapse navbar-collapse" id="navbarSupportedContent">
        	<ul class="navbar-nav ml-auto">
          		<c:choose>
					<c:when test="${sessionScope.userId == null }">
						<li class="nav-item">
            				<a class="nav-link js-scroll-trigger" href="#">모드2</a>
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
	            			<a class="nav-link js-scroll-trigger" href="/member/updateMember" data-toggle="modal" data-target="#updateModal">마이페이지</a>
	          			</li>				
					</c:when>
					<c:otherwise>
					<li class="nav-item">
	            		<a class="nav-link js-scroll-trigger" href="/">유효하지 않은 접근입니다.</a>
	          		</li>
   					</c:otherwise>
				</c:choose> 
        	</ul>
		</div>  <!-- .navbar-collapse 끝 -->
	</div>  <!-- .container-fluid 끝 -->
</nav>

 <!-- container 시작 -->
<div class="container-fluid">
	<!-- 캐릭터 row -->
	<div class="row">
		<div class="col-sm-2 col-xs-4">
			<img src='<c:url value="/resources/css/memocoChang.png" />' alt="MEMOCO" class="img-responsive memocoChang">
		</div>
		<div class="col-sm-8">
			<img src='<c:url value="/resources/css/balloon1.png" />' alt="" class="img-responsive balloon1">
		</div>
    </div>  <!-- 캐릭터 row 끝 -->
    
    <!-- 사진 입력부분 row -->
	<div class="container">
		<div class="form-row">
			<div class="col-sm-2"></div>
				<div class="col-sm-8 col-xs-12">
					<div class="row">
						<div class="col-xs-12">
							<p>*jpg확장자의 사진만 올려주세요!!</p>
              			</div>
            		</div>
            		<div class="row">
              			<div class="col-md-10">
                			<!-- form태그 -->
                			<form action="upload" id="uploadForm" method="post" enctype="multipart/form-data" class="was-validated">
                				<div class="custom-file mb-3">
                  					<input type="file" class="custom-file-input" id="input_img" name="upload" required="required" accept="image/gif,image/jpeg,image/png">
                  					<label class="custom-file-label" for="validatedCustomFile">Choose file...</label>
                  				</div>
                  				<div class="invalid-feedback">내용 입력</div>
                  				<div class="col-md-2">
            						<input type="submit" id="uploadBtn" class="btn btn-outline-secondary" value="등록">
            					</div>
                			</form> <!-- form태그 끝 -->
                		</div> 
            		</div>
            		<div class="row">
            			<div id="img_div" class="col">
              				<img id="img" class="img-responsive center-block">
            			</div>
          			</div>
        		</div>  <!-- .col-sm-8 col-sm-offset-2 끝 -->
		</div>
	</div>
</div>
    <!-- 사진 입력부분 row 끝 -->
  <!-- .container-fluid 끝 -->
  <br>
  <br>
  <br>
  <br>
  <!-- 내용 끝입니다!! -->



<script>
    // Add the following code if you want the name of the file appear on select
    $(".custom-file-input").on("change", function() {
      var fileName = $(this).val().split("\\").pop();
      $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
    });

    var sel_file;

    $(document).ready(function(){
       
       $("#input_img").on("change", handleImgFileSelect);

       function handleImgFileSelect(e){
          
          var file = e.target.files
          var fileArr = Array.prototype.slice.call(file)

          fileArr.forEach(function(f){
             if(!f.type.match("image.*")){
                alert("확장자는 이미지 확장자만 가능합니다")
                $("#input_img").val("")
                return
             }

             sel_file = f

             var reader = new FileReader()
             reader.onload = function(e){
                $("#img").attr("src",e.target.result);
             }
             reader.readAsDataURL(f)
          })
       }
    })
    
    $("#uploadForm").on("submit",function(){
    	$("#uploadBtn").attr("disabled","disabled");
	 
    })
    
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
               window.reload()
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
   
   
</script>

</body>
</html>