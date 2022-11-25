<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<aside id="group-aside">

    <div id="group-aside-header"></div>
    
    <div>
        <p id="group-nav-title" class="nav-link no-drag">나의그룹</p>
    </div>
    
    <ul id="group-aside-ul" class="text-center navbar-nav">
        <li class="nav-item"></li>
        <li class="nav-item"></li>
        
        <c:forEach items="${map.groupList}" var="groupVo">	
	        <li id="grouplist-${groupVo.groupNo}" class="nav-item">
	        	<a class="nav-link group-nav-menu 
	        		<c:if test='${groupVo.groupNo == map.groupNo}'> group-nav-active </c:if>"
	        		<c:choose>
	        			<c:when test="${map.black == true}">
	        				href="${pageContext.request.contextPath}/group/blacklist?no=${groupVo.groupNo}"
	        			</c:when>
	        			<c:otherwise>
			        		href="${pageContext.request.contextPath}/group/list?no=${groupVo.groupNo}"
	        			</c:otherwise>
	        		</c:choose> 
	        		>${groupVo.groupName}<br />
	        	</a>
	        </li>
        </c:forEach>
        
    </ul>
    <ul class="navbar-nav">
    	
    	<c:if test="${map.groupCount > 1}">
        	<li><button id="btn-order-change" class="btn btn-primary group-nav-btn" type="button" data-bs-target="#modal-group-order-change" data-bs-toggle="modal" data-count="${map.groupCount}">그룹 순서 변경</button></li>
        </c:if>
        
        <c:if test="${map.groupCount < 4}">
        	<li><a class="btn btn-primary group-nav-btn" role="button" href="add"> 새 그룹 추가</a></li>
        </c:if>
    </ul>
</aside>

   
   
<!-- 그룹 순서 변경 모달 -->
<div id="modal-group-order-change" class="modal fade" role="dialog" tabindex="-1" data-bs-auto-close="outside" aria-expanded="false">
    <div class="modal-dialog modal-dialog-top" role="document">
        <div class="modal-content">
            <div class="modal-header modal-header-custom">
                <div><span>그룹 순서 변경</span></div><button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div id="group-order" class="modal-body modal-body-custom">
            	<c:forEach items="${map.groupList}" var="groupVo">
            		<div class="group-order-area">
                    	<p id="order-${groupVo.groupOrder}">
                    		<input type="hidden" name="groupNo" value="${groupVo.groupNo}">
                    		<i class="icon ion-arrow-up-b" data-order="${groupVo.groupOrder}"
                    			<c:if test="${groupVo.groupOrder == 1}"> 
                    				style="color: rgba(0,0,0,0); cursor: dafault; pointer-events: none;"
                    			</c:if>>
                    		</i>
                    		${groupVo.groupName}
                    		<i class="icon ion-arrow-down-b" data-order="${groupVo.groupOrder}"
                    			<c:if test="${groupVo.groupOrder == map.groupCount}">
                    				style="color: rgba(0,0,0,0); cursor: dafault; pointer-events: none;"
                    			</c:if>>
                    		</i>
                    	</p>
                	</div>
            	</c:forEach>
            </div>
            <div class="modal-footer-custom">
            	<c:choose>
	            	<c:when test="${map.black == true}">
		            	<a href="${pageContext.request.contextPath}/group/blacklist?no=${map.groupNo}"><button class="btn btn-primary" type="submit">변경</button></a>
		            	<a href="${pageContext.request.contextPath}/group/blacklist?no=${map.groupNo}"><button class="btn btn-light" type="button">취소</button></a>
	            	</c:when>
	            	<c:otherwise>
		            	<a href="${pageContext.request.contextPath}/group/list?no=${map.groupNo}"><button class="btn btn-primary" type="submit">변경</button></a>
		            	<a href="${pageContext.request.contextPath}/group/list?no=${map.groupNo}"><button class="btn btn-light" type="button">취소</button></a>
	            	</c:otherwise>
            	</c:choose>
            </div>
        </div>
    </div>
</div>
 
</body>

<script type="text/javascript">

/* 그룹 개수 */
var groupCount

$("#btn-order-change").on("click", function(){
	//console.log("그룹 순서 변경 모달 열기")
	var $this = $(this)
	groupCount = $this.data("count")
	
})


$("#group-order").on("click", ".ion-arrow-up-b", function(){
	//console.log("그룹 순서 위로 보내기")
	
	$this = $(this)
	var orderNo = $this.data("order")
	var beforeNo = orderNo-1
	
	//위로 보낼 그룹 이름
	var thisName = $("#order-"+orderNo).text()
	//위로 보낼 그룹 번호
	var thisGNo = $("#order-"+orderNo+" [type='hidden']").val()
	
	//반대로 내려오게 될 그룹 이름
	var beforeName = $("#order-"+beforeNo).text()
	//반대로 내려오게 될 그룹 이름
	var beforeGNo = $("#order-"+beforeNo+" [type='hidden']").val()
	
	//위쪽 
	var str1 = ""
		str1 += '<input type="hidden" name="groupNo" value="' + thisGNo +'">'
		str1 += '<i class="icon ion-arrow-up-b" data-order="' + beforeNo +'"'
	
	if(beforeNo == 1){
		str1 += '	style="color: rgba(0,0,0,0); cursor: dafault; pointer-events: none;"'
	}
		str1 +=	'>'
		str1 += '</i>'
		str1 += thisName
		str1 += '<i class="icon ion-arrow-down-b" data-order="' + beforeNo +'"></i>'
		
	//아래쪽
	var str2 = ""
		str2 += '<input type="hidden" name="groupNo" value="' + beforeGNo +'">'
		str2 += '<i class="icon ion-arrow-up-b" data-order="' + orderNo +'"></i>'
		str2 += beforeName
		str2 += '<i class="icon ion-arrow-down-b" data-order="' + orderNo +'"' 
	
	if(orderNo == groupCount){
		str2 +=	'	style="color: rgba(0,0,0,0); cursor: dafault; pointer-events: none;"'
	}
		str2 += '>'
		str2 +=	'</i>'
	
	//바꾸기
	$("#order-"+beforeNo).html(str1)
	$("#order-"+orderNo).html(str2)
})


$("#group-order").on("click", ".ion-arrow-down-b", function(){
	//console.log("그룹 순서 아래로 보내기")
	
	$this = $(this)
	var orderNo = $this.data("order")
	var afterNo = orderNo+1
	
	//아래로 보낼 그룹 이름
	var thisName = $("#order-"+orderNo).text()
	//아래로 보낼 그룹 번호
	var thisGNo = $("#order-"+orderNo+ " [type='hidden']").val()
	
	//반대로 올라오게 될 그룹 이름
	var afterName = $("#order-"+afterNo).text()
	//반대로 올라오게 될 그룹 번호
	var afterGNo = $("#order-"+afterNo+ " [type='hidden']").val()
	
	//위쪽 
	var str1 = ""
		str1 += '<input type="hidden" name="groupNo" value="' + afterGNo +'">'
		str1 += '<i class="icon ion-arrow-up-b" data-order="' + orderNo +'"'

	if(orderNo == 1){
		str1 += '	style="color: rgba(0,0,0,0); cursor: dafault; pointer-events: none;"'
	}
		str1 += '>'
		str1 += '</i>'
		str1 += afterName
		str1 += '<i class="icon ion-arrow-down-b" data-order="' + orderNo +'"></i>'
		
	//아래쪽
	var str2 = ""
		str2 += '<input type="hidden" name="groupNo" value="' + thisGNo +'">'
		str2 += '<i class="icon ion-arrow-up-b" data-order="' + afterNo +'"></i>'
		str2 += thisName
		str2 += '<i class="icon ion-arrow-down-b" data-order="' + afterNo +'"' 
	
	if(afterNo == groupCount){
		str2 +=	'	style="color: rgba(0,0,0,0); cursor: dafault; pointer-events: none;"'
	}
		str2 += '>'
		str2 +=	'</i>'
	
	//바꾸기
	$("#order-"+orderNo).html(str1)
	$("#order-"+afterNo).html(str2)
})


$("#modal-group-order-change").on("click", ".btn-primary", function(){
	//console.log("그룹 순서 변경 버튼 클릭")
	
	var order1 = $("#order-1 [type='hidden']").val()
	var order2 = $("#order-2 [type='hidden']").val()
	var order3 = $("#order-3 [type='hidden']").val()
	var order4 = $("#order-4 [type='hidden']").val()
	
	var gpOrder = {
		order1: order1,
		order2: order2,
		order3: order3,
		order4: order4,
		groupCount: groupCount
	}
	
	$.ajax({
		url : "${pageContext.request.contextPath}/group/changeOrder",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify(gpOrder),
		dataType : "json",
		
		success : function(result){
			
			if(result != "success"){
				alert("그룹 순서 변경에 실패했습니다")
				return false

			}else{
				
				alert("그룹 순서 변경이 완료되었습니다")
				//return true
				location.replace("${pageContext.request.contextPath}/group/list?no=${map.groupNo}")
			}

		},
		error : function(XHR, status, error) {
			console.error(status + " : " + error);
			
		}
	})
		
})

</script>
