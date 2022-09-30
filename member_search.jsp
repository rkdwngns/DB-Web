<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="css/style.css">
<title>join</title>
<script type="text/javascript">
	function checkValue2() {
		if(!document.data1.in_custno.value) {
			alert("회원번호를 입력하세요.");
			data.in_custno.focus();
			return false;
		} 		
		return true;
	}
</script>
</head>
<body>
<header>쇼핑몰 ver 1.0</header>
<nav>
	<ul>
		<li herf="">회원목록</li>
		<li>회원목록조회/수정</li>
		<li>회원정보조회</li>
		<li>회원매출조회</li>
		<li>홈으로</li>
	</ul>
</nav>

<section>
<h2>회원조회</h2>
<table>
<td>
<tr>
<th>회원정보</th> <td><input type="text"></td>
</tr>
<tr class = "center">
<input type="submit" value="취소" heft= "index.jsp">
<input type = "button" value="조회" hef = "member_search_list.jsp">
</tr>
</td>
</table>
</section>

<footer>
	HRJDJF:LSKFL:SJFL:SDJF:LSDKFJ:LFKJSD:LFKJ
</footer>

</body>
</html>