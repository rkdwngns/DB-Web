#DB-Web

# 쇼핑몰 회원관리 사이트 만들기

![image](https://user-images.githubusercontent.com/93520535/186063218-9ae93371-29c6-4cb2-bd22-6ad08afe0579.png)

회원등록에 링크를 걸어 들어가줍니다. 

```jsp
<ul>
<li><a href="join.jsp">회원등록</a></li>
```

![image](https://user-images.githubusercontent.com/93520535/186063456-c0fccc79-2d47-4ccf-a6a8-6304dbb39f98.png)

# DB테이블을 생성해 놓은 쿼리문

```DB
 create table money_tbl_02(
 custno number(6),
  salenol number(8),
  pcost number(8),
  amount number(4),
  price number(8),
  pcode varchar2(4),
```
이곳에는 데이터를 넣는 DB테이블을 생성하였습니다.

# 데이터 베이스 연결 파일

```java
public static Connection getConnection() {
		Connection conn = null;
		
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String id = "system";
		String pw = "1234";
		
		try {
			Class.forName("oracle.jdbc.OracleDriver");
			conn = DriverManager.getConnection(url, id, pw);
			
			System.out.println("DB test");
		} catch(Exception e) {
			e.printStackTrace();
		}
```
System계정에 연결을 시도하고
데이터 베이스에 연결에 성공할 시에 
DBtest라는 문구가 출력 됩니다.
그리고 try와 catch문을 사용해 예외처리를 해줍니다.


![image](https://user-images.githubusercontent.com/93520535/186095219-a75194ed-27b6-4adb-ba51-de3c142b6c89.png)


# 회원번호 자동 생성 되는 코드
```jsp
<th>회원번호(자동발생)</th>
<td><input type="text" name="custno" value="<%= num %>"  readonly ></td>
</tr>

String sql="select max(custno) from member_tbl_02";

Connection conn = DBConnect.getConnection();
PreparedStatement pstmt = conn.prepareStatement(sql);
ResultSet rs = pstmt.executeQuery();
	
rs.next();
int num = rs.getInt(1)+1;
%>  
```
첫번쨰를 보시면 String sql로 시작하는 문장은 member_tbl_02라는 테이블에서
custno의 값을 max 전부 가져온다는 뜻입니다. 그리고 num에 int형태로 가져온후
```jsp
<td><input type="text" name="custno" value="<%= num %>"  readonly ></td>
```
<%= num %>을 통해 값을 넣어줍니다.

# 데이터 베이스에 정보를 추가하기 위한 join화면 입니다.

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
각 이름을 정해주고 join_p페이지에서 custon는 Intger을 사용해 int형태로 받고
나머지의 값들은 String를 사용하여 문자열로 받아줍니다.
```jsp
String sql="insert into member_tbl_02 values (?, ?, ?, ?, ?, ?, ?)";
```
이 코드를 보면 member_tbl_02 values을 sql에 넣고
PreparedStatement pstmt = conn.prepareStatement(sql);
을 통해 pstmt곳에 sql의 값을 넣어주고

```jsp
 Connection conn = DBConnect.getConnection();
 PreparedStatement pstmt = conn.prepareStatement(sql);
 
 pstmt.setInt(1, Integer.parseInt(request.getParameter("custno")));
 pstmt.setString(2, request.getParameter("custname"));
 pstmt.setString(3, request.getParameter("phone"));
```
pstmt.setString(2, request.getParameter("custname"));
그러면  (?, ?, ?, ?, ?, ?, ?)에 2번째에 값이 들어가게 됩니다.


![image](https://user-images.githubusercontent.com/93520535/186064030-7d1e2a57-22c8-426d-8792-5e564b295f09.png)


등록을 누르면 메인 화면으로 돌아가게 됩니다.


![image](https://user-images.githubusercontent.com/93520535/186064074-faa77a95-5a22-4680-ae01-ce1f5ea6c8e7.png)


변화가 없는 것 같지만

데이터 베이스값을 한 번 보겠습니다.

![image](https://user-images.githubusercontent.com/93520535/186064428-f3db0ce8-9144-45b4-af0b-e7526de702db.png)

값이 추가된것을 볼 수 있습니다.

# 회원 데이터 수정 삭제 표 만들기
```jsp
	String sql="select custno, custname, phone, address, "
	          +"to_char(joindate,'yyyy-mm-dd') joindate, "
			  +"case when grade = 'A' then 'VIP' when grade = 'B' then '일반' else '직원' end grade, "
			  +"city from member_tbl_02 order by custno asc";

```
문자열 형태로 sql에 쿼리문을 사용하여 정보를 불러옵니다..
sustno, custname, phone, address를 검색하고
to_char을 사용하여 20151211이렇게 되어있는 날짜 형식을 2015-12-11로 바꿔줍니다.
그리고 when을 사용하여 조건을 달아 등급을 매깁니다.
그리고 도시 번호를 가져와주면
```jsp
	PreparedStatement pstmt = conn.prepareStatement(sql);
```
쿼리문으로 변환 
```jsp
	ResultSet rs = pstmt.executeQuery();
```
실행후 값을 rs에 저장해 줍니다.
 표를 만들기 위한 기본적인 준비 끝났습니다.
```HTML
	<th>회원번호</th>
	<th>회원성명</th>
	<th>전화번호</th>
	<th>주소</th>
	<th>가입일자</th>
	<th>고객등급</th>
	<th>거주지역</th>
```
![image](https://user-images.githubusercontent.com/93520535/186559837-f43a805c-940f-4441-a231-0daab520bde1.png)


첫 행에 표시될 항목들을 적어줍니다.

```HTML
<%
	while(rs.next()) {
%>
<tr class="center">
	<td><%= rs.getString("custno")%></td>
	<td><%= rs.getString("custname") %></td>
	<td><%= rs.getString("phone") %></td>
	<td><%= rs.getString("address") %></td>
	<td><%= rs.getString("joindate") %></td>
	<td><%= rs.getString("grade") %></td>
	<td><%= rs.getString("city") %></td>
<td>
	<input type="button" value="수정" >
	<input type="button" value="삭제" ></td>
</tr>
<%
	}
%>
```
다음은 일일이 데이터의 값을 넣어줄 수도 있으나 
while문을 사용하여
데이터를 불러와 자동으로 값을 넣으면서 칸을 생성함으로서 자동적으로 표가 생성되게 됩니다.
그러면 다음과 같은 화면이 나오게 됩니다.

![image](https://user-images.githubusercontent.com/93520535/186560736-413977a5-048c-44fa-8eec-12bffb206dde.png)

## member_search
```jsp
int in_custno = Integer.parseInt(request.getParameter("in_custno"));
String sql="select custno, custname, phone, address, to_char(joindate,'yyyy-mm-dd') joindate," 
		+ "case when grade = 'A' then 'VIP' when grade = 'B' then '일반' else '직원' end grade,"
		+ "city from member_tbl_02 where custno =" + in_custno;

```
원하는 결과를 출력하기 위해 SQL문을 작성하여 데이터 베이스에서 값을 나타내주었습니다. 문자열로 sql에 담아 줍니다.
```jsp
	<td><%= rs.getString("custno") %></td>
	<td><%= rs.getString("custname") %></td>
	<td><%= rs.getString("phone") %></td>
	<td><%= rs.getString("address") %></td>
 	<td><%= rs.getString("joindate") %></td>
	<td><%= rs.getString("grade") %></td>
	<td><%= rs.getString("city") %></td>
```
을 통해 각 표에 문자열 형태로 표시해주겠습니다.
```jsp
	<p align="center">회원번호 <%= in_custno %>의 회원 정보가 없습니다.</p>
				
	<p align="center"> <input type="button" value="다시조회" onclick="location.href='member_search.jsp'"></p>
```
center값을 주고 정보가 없을 경우에는 <%= in_custno %>를 통해 이름을 표시해주고 ~의 정보가 없습니다를 표시하게 해주었습니다.
그리고 다시 조회에는 member_search페이지로 넘어가게 링크를 표시해주었습니다.

![image](https://user-images.githubusercontent.com/93520535/195012437-d2aed97c-db08-4bf0-8d11-dd74c47486e0.png)


![image](https://user-images.githubusercontent.com/93520535/195012478-e12258ab-6bbd-49d0-a06e-63c6dc88db69.png)

## sales_list page

![image](https://user-images.githubusercontent.com/93520535/195012652-85183055-4f5c-46bd-b0a7-afb88dd0c1aa.png)

```jsp
	String sql="select mb.custno, mb.custname, "
			  +"case when grade = 'A' then 'VIP' "
			  +"when grade = 'B' then '일반' else '직원' end grade, "
			  +"sum(mo.price) price from member_tbl_02 mb, money_tbl_02 mo "
			  +"where mb.custno = mo.custno and mo.price is not null "
			  +"group by mb.custno, mb.custname, mb.grade "
			  +"order by sum(mo.price) desc";
```
회원의 매출 및 총합을 구하기 위해 만들어둔 member테이블과 money테이블을 하나로 묶어주었습니다.
```jsp
			 i += Integer.parseInt(rs.getString("price"));  
				}
```
매출을 int형으로 바꾸고 총합을 구한뒤에 다시 getString를 사용하여 총합을 표시해줍니다.

update & update_p
```jsp
String sql="update member_tbl_02 set custname=?, phone=?, address=?, joindate=?, grade=?, city=? where custno="+ 	Integer.parseInt(request.getParameter("custno"));
```
을 통해 





