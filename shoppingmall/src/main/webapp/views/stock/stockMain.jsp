<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>주식 메인 페이지</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<style>
body {
	font-family: 'Segoe UI', sans-serif;
	background-color: #ffffff;
	margin: 0;
	padding: 0;
}

.container {
	max-width: 1000px;
	margin: 0 auto;
	padding: 20px;
}

h2 {
	font-size: 2rem;
	font-weight: 700;
	text-align: left;
	color: #000;
	margin-bottom: 40px;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 10px;
	background-color: white;
	border-radius: 8px;
	overflow: hidden;
	box-shadow: 0 8px 16px rgba(0, 0, 0, 0.05);
}

th, td {
	padding: 14px 18px;
	border-bottom: 1px solid #e0e0e0;
	text-align: center;
	color: #2c3e50;
}

th {
	background-color: #3498db;
	color: white;
	font-weight: 600;
}

tr:hover {
	background-color: #f1f8ff;
	box-shadow: 0 2px 8px rgba(52, 152, 219, 0.2);
	transition: background-color 0.3s ease, box-shadow 0.3s ease;
}

.toggle-wish {
	background: none;
	border: none;
	font-size: 22px;
	cursor: pointer;
	transition: transform 0.2s;
}

.toggle-wish:hover {
	transform: scale(1.3);
}

.wish-stock-list {
	margin-top: 50px;
	padding: 20px;
	background: #ffffff;
	border-radius: 8px;
	box-shadow: 0 6px 12px rgba(0, 0, 0, 0.05);
}

.wish-stock-list h3 {
	font-size: 1.3rem;
	margin-bottom: 15px;
	color: #2c3e50;
}

.wish-stock-list a {
	color: #3498db;
	font-weight: bold;
	text-decoration: none;
}

.wish-stock-list a:hover {
	text-decoration: underline;
}

.wish-stock-list ul {
	list-style: none;
	padding: 0;
	margin-top: 10px;
}

.wish-stock-list li {
	padding: 10px 0;
	border-bottom: 1px solid #eaeaea;
}

.recommand-stock {
	margin-top: 50px;
	padding: 20px;
	background: #ffffff;
	border-radius: 8px;
	box-shadow: 0 6px 12px rgba(0, 0, 0, 0.05);
	overflow-x: auto;
	box-sizing: border-box;
}

.recommand-stock h3.stock-title {
	font-size: 1.5rem;
	margin-bottom: 20px;
	color: #1a5276;
	font-weight: 700;
	text-align: center;
}

.recommand-stock .stock-name {
	color: #e74c3c;
}

#myChart {
	width: 100% !important;
	max-width: 100%;
	height: 400px !important;
	background-color: white;
	border-radius: 12px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
	padding: 10px;
}

@media (max-width: 600px) {
	.container {
		width: 95%;
	}
	table, thead, tbody, th, td, tr {
		display: block;
	}
	thead tr {
		display: none;
	}
	tr {
		margin-bottom: 15px;
		border-bottom: 2px solid #eee;
		padding-bottom: 10px;
	}
	td {
		text-align: left;
		padding: 10px;
		position: relative;
	}
	td::before {
		content: attr(data-label);
		font-weight: bold;
		display: inline-block;
		width: 100px;
		color: #555;
	}
}
</style>
</head>
<body>
<jsp:include page="/views/header.jsp" />

<div class="container">
	<h2>주식 정보 메인 페이지 📈</h2>

	<table>
		<thead>
			<tr>
				<th>종목명</th>
				<th>현재가</th>
				<th>찜</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list}" var="dto">
				<tr data-stock-code="${dto.stockNum}">
					<td data-label="종목명">
						<c:choose>
							<c:when test="${dto.stockName == '삼성전자' || dto.stockName == '네이버' || dto.stockName == 'LG에너지솔루션' || dto.stockName == '카카오'}">
								<a href="/stock/realStock?StockName=${dto.stockName}" style="color: #2980b9; font-weight: bold; text-decoration: none;">
									${dto.stockName}
								</a>
							</c:when>
							<c:otherwise>
								${dto.stockName}
							</c:otherwise>
						</c:choose>
					</td>
					<td data-label="현재가">${dto.price}</td>
					<td data-label="찜"><button class="toggle-wish">❤️</button></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<div class="wish-stock-list">
		<h3>내 관심 주식 목록</h3>
		<a href="/stock/wishlist">→ 관심주식 페이지로 이동</a>
		<ul id="wishStockList">
			<c:forEach var="wish" items="${wishStocks}">
				<li>${wish.stockName}</li>
			</c:forEach>
		</ul>
	</div>

	<div class="recommand-stock">
		<h3 class="stock-title">
			✨ 주식 추천: <span id="stock" class="stock-name"></span>
		</h3>
		<canvas id="myChart"></canvas>
	</div>
</div>

<script>
$(document).ready(function () {
	const wishStocks = new Set();
	<c:forEach var="wish" items="${wishStocks}">
		wishStocks.add('${wish.stockNum}');
	</c:forEach>

	$(".toggle-wish").each(function () {
		const stockCode = $(this).closest("tr").data("stock-code");
		$(this).text(wishStocks.has(stockCode) ? "❤️" : "💔");
	});

	$(".toggle-wish").on("click", function () {
		const row = $(this).closest("tr");
		const stockCode = row.data("stock-code");
		const btn = $(this);

		$.ajax({
			url: "/stock/toggleFavorite",
			method: "POST",
			data: { stockCode: stockCode },
			success: function (res) {
				alert(res.message);
				btn.text(wishStocks.has(stockCode) ? "💔" : "❤️");
				wishStocks.has(stockCode) ? wishStocks.delete(stockCode) : wishStocks.add(stockCode);

				let item = "";
				$.each(res.wishStocks, function(idx, dto){
					item += "<li>"+ dto.stockName  + "</li>";
				});
				$("#wishStockList").html(item);
			},
			error: function () {
				alert("로그인이 필요합니다.");
			}
		});
	});
});
</script>

<script>
let chart;

function createChart(data) {
	const MAX_LENGTH = 23000;
	const ctx = document.getElementById('myChart').getContext('2d');

	if (chart) chart.destroy();

	const drawLastValuePlugin = {
		id: 'drawLastValue',
		afterDatasetsDraw(chart) {
			const ctx = chart.ctx;
			chart.data.datasets.forEach((dataset, i) => {
				const meta = chart.getDatasetMeta(i);
				const dataPoints = meta.data;
				for (let j = dataPoints.length - 1; j >= 0; j--) {
					const value = dataset.data[j];
					const point = dataPoints[j];
					if (value !== null && !isNaN(value) && point) {
						ctx.save();
						ctx.fillStyle = dataset.borderColor || 'black';
						ctx.font = 'bold 14px Arial';
						ctx.textAlign = 'left';
						ctx.textBaseline = 'middle';
						ctx.fillText(value, point.x + 10, point.y - 10);
						ctx.restore();
						break;
					}
				}
			});
		}
	};

	let prices = data.map(item => item.price);
	let stockName = data.map(item => item.stockName)[0];

	if (prices.length < MAX_LENGTH) {
		prices = prices.concat(new Array(MAX_LENGTH - prices.length).fill(null));
	}
	const labels = Array.from({ length: MAX_LENGTH }, (_, i) => i);
	const validPrices = prices.filter(p => p !== null && !isNaN(p));
	const priceMin = Math.min(...validPrices) - 1000;
	const priceMax = Math.max(...validPrices) + 1000;

	chart = new Chart(ctx, {
		type: 'line',
		data: {
			labels: labels,
			datasets: [{
				label: 'Price',
				data: prices,
				borderColor: 'rgba(255, 99, 132, 1)',
				borderWidth: 1,
				pointRadius: 0,
				fill: false,
				tension: 0.1
			}]
		},
		options: {
			animation: false,
			responsive: true,
			maintainAspectRatio: false,
			scales: {
				x: {
					display: true,
					min: 0,
					max: MAX_LENGTH,
					ticks: {
						display: false,
						maxTicksLimit: 20
					}
				},
				y: {
					min: priceMin,
					max: priceMax,
					ticks: {
						stepSize: 10
					}
				}
			},
			plugins: {
				legend: { display: true }
			}
		},
		plugins: [drawLastValuePlugin]
	});

	chart.render();
	$("#stock").html(stockName);
}

function fetchData() {
	$.ajax({
		url: "/stock/realtime",
		type: "GET",
		dataType: "json",
		success: function(result) {
			createChart(result);
		},
		error: function(xhr, status, error) {
			console.error("데이터 요청 실패:", error);
		}
	});
}
fetchData();
setInterval(fetchData, 30000);
</script>

<jsp:include page="/views/footer.jsp" />
</body>
</html>
