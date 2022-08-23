#DB-Web

#DB를 사용해 회원등록 사이트 만들기

![image](https://user-images.githubusercontent.com/93520535/186063218-9ae93371-29c6-4cb2-bd22-6ad08afe0579.png)

회원등록에 링크를 걸어 들어가줍니다. 

```jsp
<ul>
<li><a href="join.jsp">회원등록</a></li>
```

![image](https://user-images.githubusercontent.com/93520535/186063456-c0fccc79-2d47-4ccf-a6a8-6304dbb39f98.png)

데이터 베이스에 정보를 추가하기 위한 join화면 입니다.

```jsp
<script type="text/javascript">W
	function checkValue() {
		if(!document.data.custname.value) {
			alert("회원성명을 입력하세요.");
			data.custname.focus();
			return false;
            
<th>회원번호(자동발생)</th>
	<td><input type="text" name="custno" value="<%= num %>"  readonly ></td>
	</tr>
     <tr>
	<th>회원성명</th>
	<td><input type="text" name="custname" ></td>
	</tr>            
```
각 이름을 정해주고 join_p페이지에서 값을 받습니다.

```jsp
 request.setCharacterEncoding("UTF-8");
 String sql="insert into member_tbl_02 values (?, ?, ?, ?, ?, ?, ?)";
 
 Connection conn = DBConnect.getConnection();
 PreparedStatement pstmt = conn.prepareStatement(sql);
 
 pstmt.setInt(1, Integer.parseInt(request.getParameter("custno")));
 pstmt.setString(2, request.getParameter("custname"));
 pstmt.setString(3, request.getParameter("phone"));
```

![image](https://user-images.githubusercontent.com/93520535/186064030-7d1e2a57-22c8-426d-8792-5e564b295f09.png)

등록을 누르면 메인 화면으로 돌아가게 됩니다.

![image](https://user-images.githubusercontent.com/93520535/186064074-faa77a95-5a22-4680-ae01-ce1f5ea6c8e7.png)

변화가 없는 것 같지만

데이터 베이스값을 한 번 보겠습니다.


![image](https://user-images.githubusercontent.com/93520535/186064428-f3db0ce8-9144-45b4-af0b-e7526de702db.png)


값이 추가된것을 볼 수 있습니다.










