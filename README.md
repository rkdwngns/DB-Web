#DB-Web

# DB를 사용해 회원등록 사이트 만들기

![image](https://user-images.githubusercontent.com/93520535/186063218-9ae93371-29c6-4cb2-bd22-6ad08afe0579.png)

회원등록에 링크를 걸어 들어가줍니다. 

```jsp
<ul>
<li><a href="join.jsp">회원등록</a></li>
```

![image](https://user-images.githubusercontent.com/93520535/186063456-c0fccc79-2d47-4ccf-a6a8-6304dbb39f98.png)

DB테이블을 생성해 놓은 쿼리문

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

데이터 베이스 연결 파일

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
회원번호 자동 생성 되는 코드
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
