<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script src="/resources/js/jquery-3.4.1.min.js"></script>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" 
	integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
	<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
	 integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" 
	integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" 
	integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
	<script src="/resources/js/bootstrap.min.js"></script>
	<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
	<script>
	$(function(){

		var sel_file;
		$(document).on("change",'.inputfile', handleImgFileSelect);

		function handleImgFileSelect(e){
	 		var file = e.target.files
			var fileArr = Array.prototype.slice.call(file)
			
			var imgSelect = $(this).prev()
			
			fileArr.forEach(function(f){
				if(!f.type.match("image.*")){
					alert("확장자는 이미지 확장자만 가능합니다")
					$(".inputfile").val("")
					return;
				}

				sel_file = f

				var reader = new FileReader()
				reader.onload = function(e){
				imgSelect.attr("src",e.target.result);
					
				}
				
				reader.readAsDataURL(f)
	 			/* $('img').css({
					"left": "50%",
					"margin-left": "-"+( $(this).width()/2 )+"px",
					"top": "50%",
					"margin-top": "-"+( $(this).height()/2 )+"px"
				}); */
	 		
	 		})
	 	}


	})
	

	</script>
</head>
<body>
<h1><a href="/">홈으로</a></h1>
<form action="/recipe/insertRecipe" method="post" enctype="multipart/form-data">
<table border="1" id="recipe">
	<tr>
		<th>
			요리제목 : 
		</th>
		<td>
			<input type="text" name="recipe_title">
		</td>
	</tr>
	<tr>
		<th>
			작성자 : 
		</th>
		<td>
			${sessionScope.nickName }
		</td>
	</tr>
</table>
<table border="1" id="recipeContent">
	<tr>
		<th>
			<span class="image_num">1</span>레시피 사진
		</th>
		<td>
			<img>
			<input type="file" name="recipe_image" class="inputfile" multiple="multiple">
		</td>
	</tr>
	<tr>
		<th>
			<span class="content_num">1</span>레시피 내용
		</th>
		<td>
			<input type="text" name="recipe_content">
			<input type="button" class="removeContent" value="요리과정삭제">
		</td>
	</tr>
</table>
<table border="1" id="recipeIngrd">
	<tr>
		<th>
			<span class="name_num">1</span>재료명
		</th>
		<th>
			<input type="text" name="ingrd_name">
		</th>
	</tr>	
	<tr>
		<th>
			<span class="amount_num">1</span>재료양
		</th>
		<th>
			<input type="text" name="ingrd_amount">
			<input type='button' class='removeIngrd' value='요리재료삭제'>
		</th>
	</tr>
</table>
<table border="1">	
	<tr id="btntr">
		<th colspan="2">
			<input type="submit" value="등록">
<!-- 			<input type="reset" value="다시쓰기">
			<input type="button" value="취소" onclick="location.href='/'"> -->		
		</th>
	</tr>
</table>

</form>
	<input type="button" class="addContent" value="요리과정추가">
	<input type="button" class="addIngrd" value="요리재료추가">
</body>
<script>
	var content_last_num;
	var ingrd_last_num;
	
	$(function(){

		$(document).on("click",":button",function(){
			var btn_val = $(this).val();
			
			
			if(btn_val == '요리과정추가'){
				content_last_num = Number($("#recipeContent").children("tbody").children("tr:last").children("th:first").children("span").text())
				
				//content_last_num = Number();

				var output = ""
				output += "<tr>"
				output += 	"<th>"
				output += 		"<span class='image_num'>"+(content_last_num +1)+"</span>레시피 사진"	
				output += 	"</th>"
				output += 	"<td>"
				output += 		"<img>"
				output += 		"<input type='file' name='recipe_image' class='inputfile'>"	
				output += 	"</td>"
				output += "</tr>"
				output += "<tr>"
				output += 	"<th>"
				output += 	"<span class='content_num'>"+(content_last_num+1)+"</span>레시피 내용"
				output += 	"</th>"
				output += 	"<td>"
				output += 		"<input type='text' name='recipe_content'>"
				output += 		"<input type='button' class='deletebtn' value='요리과정삭제'>"
				output += 	"</td>"	
				output += "</tr>"

					$("#recipeContent").children("tbody").append(output)

			} else if(btn_val == '요리과정삭제'){
				//alert($(this).parent().prev().children("span").text())
				$(this).parent().parent().prev().remove()
				$(this).parent().parent().remove()
				
				var cnt = 1;
				$(".image_num").each(function(){
					$(this).text(cnt)
					cnt = cnt + 1
				})
				cnt = 1
				$(".content_num").each(function(){
					$(this).text(cnt)
					cnt = cnt + 1
				})
			} else if(btn_val == '요리재료추가'){
				ingrd_last_num = Number($("#recipeIngrd").children("tbody").children("tr:last").children("th:first").children("span").text())
	
				var output = ""
				output += "<tr>"
				output += 	"<th>"
				output += 		"<span class='name_num'>"+(ingrd_last_num +1)+"</span>재료명"	
				output += 	"</th>"
				output += 	"<th>"
				output += 		"<input type='text' name='ingrd_name'>"	
				output += 	"</th>"
				output += "</tr>"
				output += "<tr>"
				output += 	"<th>"
				output += 	"<span class='amount_num'>"+(ingrd_last_num+1)+"</span>재료양"
				output += 	"</th>"
				output += 	"<th>"
				output += 		"<input type='text' name='ingrd_amount'>"
				output += 		"<input type='button' class='removeIngrd' value='요리재료삭제'>"
				output += 	"</th>"	
				output += "</tr>"
				$("#recipeIngrd").children("tbody").append(output)
			} else if(btn_val = '요리재료삭제'){
				$(this).parent().parent().prev().remove()
				$(this).parent().parent().remove()

				var cnt = 1;
				$(".name_num").each(function(){
					$(this).text(cnt)
					cnt = cnt + 1
				})
				cnt = 1
				$(".amount_num").each(function(){
					$(this).text(cnt)
					cnt = cnt + 1
				})
			}
		})
		
	})
	
</script>

</html>