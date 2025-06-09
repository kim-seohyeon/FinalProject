<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>실시간 주식 정보</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 40px;
        }
        #realtime-data {
            border: 1px solid #ccc;
            padding: 20px;
            height: 300px;
            overflow-y: auto;
            background: #f9f9f9;
        }
    </style>
</head>
<body>
    <h2>실시간 주식 정보 📦</h2>
    <div id="realtime-data">데이터 수신 대기 중...</div>

    <script>
        const socket = new WebSocket("ws://localhost:8080"); // 실제 WebSocket 서버 주소

        socket.onmessage = function(event) {
            const data = event.data; // Kafka에서 전달된 JSON 또는 텍스트
            const div = document.getElementById("realtime-data");
            const p = document.createElement("p");
            p.textContent = `[${new Date().toLocaleTimeString()}] ${data}`;
            div.appendChild(p);
            div.scrollTop = div.scrollHeight;
        };

        socket.onopen = function() {
            console.log("WebSocket 연결 성공");
        };

        socket.onerror = function(err) {
            console.error("WebSocket 오류:", err);
        };
    </script>
</body>
</html>
