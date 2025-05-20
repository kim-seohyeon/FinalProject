/**
 * 
 */
$(function(){
	$("#checkBoxs").click(function(){
		if($(this).prop("checked")){
			$("input:checkbox[name=nums]").prop("checked", true);
		}else{
			$("input:checkbox[name=nums]").prop("checked", false);
		}
	});
	$("input:checkbox[name=nums]").click(function(){
		var tot = $("input:checkbox[name=nums]").length;
		var cnt = $("input:checkbox[name=nums]:checked").length;
		if(tot == cnt)$("#checkBoxs").prop("checked", true);
		else $("#checkBoxs").prop("checked", false);
	});
	
});