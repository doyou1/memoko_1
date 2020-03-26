<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1><a href="/">홈으로</a></h1>
<div class="container">
  <c:forEach items="${recipeList}" var="recipe">
  <div class="row">
    <div class="col-sm">
		<p><a href="/recipe/recipeReadForm?listnum=${recipe.listnum}">이름 : ${recipe.listname}</a></p>
		<div>
		<p>재료명</p>
			<c:forEach items="${recipe.listingrd}" var="ingrd" varStatus="status">
				<span> ${status.count} : ${ingrd},</span>
			</c:forEach>
		</div>
    </div>
  </div>
  	</c:forEach>
</div>

</body>
</html>