<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="/resources/js/jquery-3.4.1.min.js"></script>
<script src="https://davidlynch.org/projects/maphilight/jquery.maphilight.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>


<script>
	$(function(){

		$("area").on("click",function(){
			alert($(this).attr("title"))
		})
        
		$('.map').maphilight();

		
		
	})
	
	function appendInput(){
		var last =$("#inputdiv div:last-child > input:last-child");
		var last_class = last.attr("class")
		var last_num = Number(last_class.slice(5))

		var inputdiv = $("#inputdiv")

		var output = "";
		output += "<div id='div"+(last_num+1)+"'>";
		output += "<input type='text' name='food' class='area"+(last_num+1)+"_text' value='${subimage.value}' >"
		output += "<input type='button' class='.area"+(last_num+1)+"' value='수정'>"
		output += "<input type='button' class='.area"+(last_num+1)+"' value='삭제'>"

		inputdiv.append(output)
	}

	
	
</script>
<style>
	#img_div{
		overflow: hidden;
	}
/* 	#img{
		width : 350px;
		height : 500px;
	}	
 */</style>
<title>Result</title>
</head>
<body>

<h1><a href="/">홈으로</a></h1>

	<div class="container">	
	      <div class="row">
	        <div class="col col-lg-2">
				
					<img class="map" src="display" usemap="#map">
					<map name="map">
						<c:forEach items="${list}" var="subimage" varStatus="status">
							<c:if test="${subimage.value != ''}">
								<area shape="rect" class="area${status.count}" title="${subimage.value}" alt="${subimage.value}" 
									coords="${subimage.x1},${subimage.y1},${subimage.x2},${subimage.y3}">	
							</c:if>
						</c:forEach>
					</map>
					
	      	</div>
	        <div class="col-md-auto">
				
				<form action="/recipe/findRecipeList" id="findRecipeForm" method="post">
					<div id="inputdiv">
						<c:forEach  items="${list}" var="subimage" varStatus="status">
							<c:if test="${subimage.value != ''}">
								<div id="div${status.count}">
									<input type="text" name="food" class="area${status.count}_text" value="${subimage.value}" >
									<input type="button" class=".area${status.count}" value="수정">
									<input type="button" class=".area${status.count}" value="삭제">
								</div>
							</c:if>
						</c:forEach>
					</div>
					
					<div>
						<input type="button" value="추가" onclick="appendInput()">
					</div>
					
					<p>
						<input type="submit" value="레시피추천" id="findBtn">
					</p>					
				</form>
					        
	        </div>
	    </div><!-- /.row -->
	</div><!-- /.container -->

<script>
$(function(){

	$("#inputdiv").on("click","input[type=button]",function(event){

			var class_val = $(event.target).attr("class");
			var input_val = $(class_val+'_text').val();
			
		if($(event.target).val() == "수정"){
			if(input_val != ""){
				$("area"+class_val+"").attr("title",input_val)
				$("area"+class_val+"").attr("alt",input_val)
			} else {
				alert('수정할 값을 입력해주세요');
				return false;
			}

		} else if($(event.target).val() == "삭제"){
			$(class_val).remove();
			$(this).parent().remove();
		}
	})	

    $("input[type=text]").mouseover(function(e) {
    	var class_val = $(this).attr("class");
    	class_val = class_val.split("_")[0];
		class_val = '.'+class_val
    	$(class_val).mouseover();
    }).mouseout(function(e) {
    	var class_val = $(this).attr("class");
    	class_val = class_val.split("_")[0];
		class_val = '.'+class_val
    	$(class_val).mouseout();
    })

    $("input[type=text]").focus(function(e) {
    	var class_val = $(this).attr("class");
    	class_val = class_val.split("_")[0];
		class_val = '.'+class_val
    	$(class_val).mouseover();
    }).focusout(function(e) {
    	var class_val = $(this).attr("class");
    	class_val = class_val.split("_")[0];
		class_val = '.'+class_val
    	$(class_val).mouseout();
    })

	$("#findRecipeForm").on("submit",function(){
		$("#findBtn").attr("disabled","disabled")
	})
})
</script>

</body>
</html>