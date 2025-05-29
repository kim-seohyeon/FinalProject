<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>자료 수정</title>
<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #ffffff;
        margin: 0;
        padding: 0;
    }

    .container {
        max-width: 700px;
        margin: 50px auto;
        background: #ffffff;
        border-radius: none;
        padding: 30px 40px;
        box-shadow: none;
    }

    h1 {
        text-align: center;
        color: #2c3e50;
        margin-bottom: 30px;
        font-size: 28px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
    }

    th {
        text-align: left;
        padding: 12px 10px;
        color: #34495e;
        width: 20%;
        vertical-align: top;
    }

    td {
        padding: 12px 10px;
    }

    input[type="text"],
    textarea {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 8px;
        font-size: 14px;
        box-sizing: border-box;
    }

    input[type="file"] {
        font-size: 14px;
        padding: 5px 0;
    }

    .error {
        color: #e74c3c;
        font-size: 13px;
        margin-top: 5px;
        display: block;
    }

    .submit-row {
        text-align: center;
        padding-top: 20px;
    }

    input[type="submit"], button {
        background-color: #3498db;
        color: white;
        padding: 10px 24px;
        border: none;
        border-radius: 8px;
        font-size: 16px;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    input[type="submit"]:hover, button:hover {
        background-color: #2980b9;
    }

    button.delete-btn {
        background-color: #e74c3c;
        font-size: 13px;
        padding: 6px 14px;
        margin-left: 10px;
        transition: background-color 0.3s;
    }

    button.delete-btn:hover {
        background-color: #c0392b;
    }

    .file-list, .image-section {
        margin-top: 8px;
        font-weight: 600;
        color: #2c3e50;
    }

    .image-section {
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .image-section span#image {
        font-weight: 500;
    }
</style>
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.1.min.js"></script>
<script type="text/javascript">
function fileDel(btn, org, store, kind){
    $.ajax({
        type:'post',
        url:'/file/fileDel',
        data:{"orgFile": org,"storeFile":store},
        dataType:'text',
        success: function(result){
            if($(btn).text() == "삭제"){
                $(btn).text("삭제취소");
                if(kind == 'image'){
                    $("#imageFile").html("<input type='file' name='libImageFile' />");
                    $("#image").text("");
                }
            }else{
                $(btn).text("삭제");
                if(kind == 'image'){
                    $("#imageFile").html("");
                    $("#image").text(org);
                }
            }
        },
        error:function(){
            alert("서버오류");
        }
    });
}
</script>
</head>
<body>

<jsp:include page="/views/header.jsp" />

<div class="container">
    <h1>자료 수정</h1>
    <form:form action="libUpdate" method="post" modelAttribute="libraryCommand" enctype="multipart/form-data">
        <form:hidden path="libNum" />
        <table>
            <tr>
                <th>제목</th>
                <td>
                    <form:input path="libSubject" />
                    <form:errors path="libSubject" cssClass="error" />
                </td>
            </tr>
            <tr>
                <th>글쓴이</th>
                <td>
                    <form:input path="libWriter" />
                    <form:errors path="libWriter" cssClass="error" />
                </td>
            </tr>
            <tr>
                <th>내용</th>
                <td>
                    <form:textarea path="libContent" rows="5" />
                    <form:errors path="libContent" cssClass="error" />
                </td>
            </tr>
            <tr>
                <th>파일</th>
                <td>
                    <c:set var="originalFileName" value="${fn:split(libraryCommand.libOriginalName,'`') }"/>
                    <c:forTokens items="${libraryCommand.libStoreName }" delims="`" var="fileName" varStatus="idx">
                        <div class="file-list">
                            ${originalFileName[idx.index]}
                            <button type="button" class="delete-btn" onclick="fileDel(this,'${originalFileName[idx.index]}','${fileName}')">삭제</button>
                        </div>
                    </c:forTokens>
                    <input type="file" name="libFile" multiple="multiple" />
                </td>
            </tr>
            <tr>
                <th>이미지파일</th>
                <td>
                    <span id="imageFile">
                        <c:if test="${empty fn:trim(libraryCommand.libImageOriginalName)}">
                            <input type="file" name="libImageFile" />
                        </c:if>
                    </span>
                    <c:if test="${!empty fn:trim(libraryCommand.libImageOriginalName)}">
                        <div class="image-section">
                            <span id="image">${libraryCommand.libImageOriginalName}</span>
                            <button type="button" class="delete-btn" onclick="fileDel(this,'${libraryCommand.libImageOriginalName}','${libraryCommand.libImageStoreName}', 'image')">삭제</button>
                        </div>
                    </c:if>
                </td>
            </tr>
        </table>
        <div class="submit-row">
            <input type="submit" value="자료 수정 완료" />
        </div>
    </form:form>
</div>

<jsp:include page="/views/footer.jsp" />
</body>
</html>
