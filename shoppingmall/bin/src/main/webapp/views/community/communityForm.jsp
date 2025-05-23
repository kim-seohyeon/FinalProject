<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>   
<html>
<head>
<meta charset="UTF-8">
<title>글 쓰기 폼</title>
</head>
<body>
<h2>글 등록</h2>

    <form name="communityForm" action="write" method="post">
        <table  border="1" width="600" align="center">
 		<tr><th width="100">글번호</th>
      		<td><input type="text" name="communityNum" value="${communityCommand.communityNum }" />번호 자동 부여</td></tr>
            <tr><th>작성자</th>
      			<td><input type="text" name="communityWriter" required /></td></tr>
            <tr><th>제목</th>
      			<td><input type="text" name="communitySubject" required /></td></tr> 
            <tr><th>내용</th>
			    <td><textarea rows="10" cols="50" name="communityContent" required></textarea></td></tr>

	        
	  
 		   <tr><th colspan="2"><input type="submit" value="글등록" /></th></tr>
        </table>
    </form>
    <br>
    <a href="/community">목록으로 돌아가기</a>
</body>
</html>