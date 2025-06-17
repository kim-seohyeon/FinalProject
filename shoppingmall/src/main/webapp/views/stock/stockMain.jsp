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



@media ( max-width : 600px) {
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

#chartContainer {
	width: 950px;
	height: 400px;
	margin: 0 auto;
}

#myChart {
	width: 950px !important;
	height: 400px !important;
	background-color: white;
}

#myChart {
	width: 950px !important;
	height: 400px !important;
	background-color: white;
	border-radius: 12px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
	padding: 10px;
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
				<c:forEach items="${list }" var="dto" varStatus="idx">
					<tr data-stock-code="${dto.stockNum }">
						<td data-label="종목명"><c:choose>
								<c:when test="${dto.stockName == '삼성전자'}">
									<a href="/stock/realStock?StockName=${dto.stockName}"
										style="color: #2980b9; font-weight: bold; text-decoration: none;">
										${dto.stockName} </a>
								</c:when>
								<c:when test="${dto.stockName == '네이버'}">
									<a href="/stock/realStock?StockName=${dto.stockName}"
										style="color: #2980b9; font-weight: bold; text-decoration: none;">
										${dto.stockName} </a>
								</c:when>
								<c:when test="${dto.stockName == 'LG전자'}">
									<a href="/stock/realStock?StockName=${dto.stockName}"
										style="color: #2980b9; font-weight: bold; text-decoration: none;">
										${dto.stockName} </a>
								</c:when>
								<c:when test="${dto.stockName == '카카오'}">
									<a href="/stock/realStock?StockName=${dto.stockName}"
										style="color: #2980b9; font-weight: bold; text-decoration: none;">
										${dto.stockName} </a>
								</c:when>
								<c:otherwise>
                                ${dto.stockName}
                            </c:otherwise>
							</c:choose></td>
						<td data-label="현재가">${dto.price }</td>
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
					<li>${wish.stockName} <br />
					</li>
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
                    refreshWishList(res.wishStocks);

                    if (wishStocks.has(stockCode)) {
                        btn.text("💔");
                        wishStocks.delete(stockCode);
                    } else {
                        btn.text("❤️");
                        wishStocks.add(stockCode);
                    }
                    item = "";
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

        function refreshWishList(wishes) {
            const list = $("#wishStockList");
            list.empty();
            wishes.forEach(w => {
                list.append(`<li>${w.stockNum}</li>`);
            });
        }
    });
</script>

<script>
let chart;

function createChart(data) {
  const MAX_LENGTH = 23000;
  const ctx = document.getElementById('myChart').getContext('2d');

  if (chart) {
    chart.destroy();
  }
   

  // 커스텀 플러그인 선언 — 마지막 값을 그래프에 출력
const drawLastValuePlugin = {
  id: 'drawLastValue',
  afterDatasetsDraw(chart) {
    const ctx = chart.ctx;
    chart.data.datasets.forEach((dataset, i) => {
      const meta = chart.getDatasetMeta(i);
      const dataPoints = meta.data;

      // 마지막 유효 데이터 포인트 찾기
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
          break; // 마지막 유효 데이터만 출력
        }
      }
    });
  }
};

  // 원본 가격 데이터
  let prices = data.map(item => item.price);
  let stockName = data.map(item => item.stockName)[0];

  // 가격 데이터가 부족하면 null로 채워서 MAX_LENGTH 길이에 맞추기
  if (prices.length < MAX_LENGTH) {
    const padding = new Array(MAX_LENGTH - prices.length).fill(null);
    prices = prices.concat(padding);
  }

  // 라벨은 0에서 MAX_LENGTH까지 순차적으로 설정
  const labels = Array.from({ length: MAX_LENGTH }, (_, i) => i);

  // 유효한 가격만 필터링 후 최소, 최대값 설정
  const validPrices = prices.filter(p => p !== null && !isNaN(p));
  const priceMin = Math.min(...validPrices) - 1000;
  const priceMax = Math.max(...validPrices) + 1000;

  // 차트 생성
  chart = new Chart(ctx, {
    type: 'line',
    data: {
      labels: labels,
      datasets: [{
        label: 'Price',
        data: prices,
        borderColor: 'rgba(255, 99, 132, 1)', // 선 색상
        borderWidth: 1,
        pointRadius: 0,  // 데이터 포인트 표시 안함
        fill: false, // 선 아래 색 채우지 않음
        tension: 0.1 // 선의 곡률
      }]
    },
    options: {
      animation: false,
      responsive: true,  // 차트 크기 조정
      maintainAspectRatio: false,  // 가로세로 비율 고정 안함
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
    plugins: [drawLastValuePlugin]  // 플러그인 배열에 넣기
  });

  // 차트 렌더링 후 마지막 값 출력
  chart.render();
  $("#stock").html(stockName);
}


function fetchData() {
	  $.ajax({
	    url: "/stock/realtime",
	    type: "GET",
	    dataType: "json",
	    success: function(result) {
		  console.log(result)
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
