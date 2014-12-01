<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%@ page import ="java.sql.Connection" %>
<%@ page import ="java.sql.PreparedStatement" %>
<%@ page import ="java.sql.ResultSet" %>
<%@ page import ="java.sql.SQLException" %>

<%@ page import = "javax.naming.Context" %>
<%@ page import = "javax.naming.InitialContext" %>
<%@ page import = "javax.naming.NamingException" %>
<%@ page import = "javax.sql.DataSource" %>    
    
<% 
	request.setCharacterEncoding("utf-8");
	String seq = request.getParameter("seq");
	String subject = "";
	String writer = "";
	String mail = "";
	String password = "";
	String content = "";
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
  try{
			Context initctx = new InitialContext();
			Context envCtx = (Context)initctx.lookup("java:comp/env");
			DataSource dataSource = (DataSource)envCtx.lookup("jdbc/oracle");
			conn = dataSource.getConnection();
			
			String sql = "select subject,writer,mail,password,content from board1 where seq = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,seq);
			pstmt.executeUpdate();
			
			rs = pstmt.executeQuery();
		  if(rs.next()){
		    	
		    	subject = rs.getString("subject"); 
		    	writer = rs.getString("writer");
		    	mail = rs.getString("mail") == null? "" : rs.getString("mail");
		    	content = rs.getString("content") == null? "" : rs.getString("content").replaceAll("\n", "<br/>");
		    }
			
		}catch(NamingException e){
			System.out.println("Namming error :" + e.getMessage());
		}catch(SQLException e){
			System.out.println("SQL error :" + e.getMessage());
		}finally{
	         if(rs!=null) rs.close();
			 		 if(pstmt!=null)pstmt.close();
	         if(conn!=null) conn.close();
		}	
%>    
    
    
<html>
<head>
<title></title>
<meta http-equiv='Content-Type' content='text/html;charset=utf-8'>
<link rel='stylesheet' type='text/css' href='../images/common.css'>
<script type="text/javascript">
	function ChkForm(form) {
	}
</script>
</head>

<body bgcolor='#ffffff' topmargin='5' rightmargin='0' leftmargin='5' bottommargin='10'>



<table width='750px' border='0' cellpadding='0' cellspacing='0' align='center'>
<tr>
	<td height='23' bgcolor='#f0f0f0' align='right'></td>
</tr>
<tr>
	<td bgcolor='#ffffff' style='padding:20'>
		<form action='board_modify1_ok.jsp' method='post' name='mfrm' onSubmit='return ChkForm(this)'>
		<input type="hidden" name ="seq" value="<%=seq%>"/>
		<table width='100%' border='0' cellpadding='0' cellspacing='0'>
		<tr>
			<td width='70' style='padding:5' valign='top' align='right'>
				<font class='titdot'>&#149;&nbsp;</font>
				<font class='title'>제목</font> :
			</td>
			<td>
				<input type='text' name='subject' value= '<%=subject%>' size='80' class='form'>
			</td>
		</tr>
		<tr>
			<td colspan='2' class='imgline'></td>
		</tr>
		<tr>
			<td width='70' style='padding:5' valign='top' align='right'>
				<font class='titdot'>&#149;&nbsp;</font>
				<font class='title'>작성자</font> :
			</td>
			<td>
				이름&nbsp;&nbsp;<input type='text' name='writer' value='<%=writer%>' size='10' maxlength='10' class='form' readonly>&nbsp;&nbsp;/&nbsp;
				메일&nbsp;&nbsp;<input type='text' name='mail' value='<%=mail%>' size='40' maxlength='70' class='form'>&nbsp;&nbsp;/&nbsp;
				암호&nbsp;&nbsp;<input type='password' name='password' size='10' maxlength='10' class='form'>
			</td>
		</tr>
		<tr>
			<td colspan='2' class='imgline'></td>
		</tr>
		<tr>
			<td width='70' style='padding:5' valign='top' align='right'>
				<font class='titdot'>&#149;&nbsp;</font>
				<font class='title'>내용</font> :
			</td>
			<td>
				<textarea name='content' style='width:620;height:300' class='form'><%=content%> </textarea>
			</td>
		</tr>
		<tr>
			<td colspan='2' class='gline'></td>
		</tr>
		</table>

		<table width='100%' cellpadding='0' cellspacing='0' border='0'>
		<tr>
			<td width='500' height='30'>&nbsp;</td>
			<td align='right'>
				<a href="board_modify1_ok.jsp?seq=<%=seq%>"><input type="image" src="../images/btn_mod.gif" border="0"/></a> &nbsp;
				<%-- <a href='board_modify1_ok.jsp?seq=<%=seq%>'><input type='image' src='../images/btn_mod.gif' border='0'></a> &nbsp; --%>
				<a href='board_list1.jsp'><img src='../images/btn_list.gif' border='0'></a>&nbsp;
				<a href='javascript:history.back();'><img src='../images/btn_view.gif' border='0'></a>
			</td>
		</tr>
		</table>
		</form>
	</td>
</tr>
</table>		
		
<table width='750px' border='0' cellpadding='0' cellspacing='0' align='center'>
<tr>
	<td height='15' bgcolor='#f0f0f0' style='padding:5' align='center'></td>
</tr>
</table>


</body>
</html>
