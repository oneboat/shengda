<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link href="js/kindeditor-4.1.10/themes/default/default.css" type="text/css" rel="stylesheet">

<link href="css/uploadfile.css" rel="stylesheet"> 
<script src="js/jquery.uploadfile.js"></script>
<script src="js/malsup.github.iojquery.form.js"></script>

<script type="text/javascript" charset="utf-8" src="js/kindeditor-4.1.10/kindeditor-all-min.js"></script>
<script type="text/javascript" charset="utf-8" src="js/kindeditor-4.1.10/lang/zh_CN.js"></script>

<div style="padding:10px 10px 10px 10px">
	<form id="orderAddForm" class="orderForm" method="post">
	    <table cellpadding="5" >
	        <tr>
	            <td>测试输入框:</td>
	            <td>
	            	<input class="easyui-textbox" type="text" name="orderId" data-options="required:true"></input>
	            </td>
	        </tr>
	        <tr>
	            <td >图片上传:</td>
	            <td >
	            	 <a href="javascript:void(0)"  style="background:#fff3f3;" class="easyui-linkbutton picFileUpload">上传图片</a>
	                 <input class="easyui-validatebox" type="hidden" id="image" name="image" data-options="required:true,validType:'url'"/>
	            </td>
	        </tr>
	        <tr>
	            <td >附件上传:</td>
	            <td>
	                 <!-- <iframe src="file_upload.jsp"></iframe>  -->
	                 <div id="orderAddFileUploader" >上传文件</div>
	                 <input  type="hidden" id="orderAddFile" name="file" />
	            </td>
	        </tr>

	    </table>
	    <input type="hidden" name="orderParams"/>
	</form>
	<div style="padding:5px">
	    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitOrderAddForm()">提交</a>
	    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearOrderADDForm()">重置</a>
	</div>
</div>
<script type="text/javascript">
	
	//页面初始化完毕后执行此方法
	$(function(){
		//加载附件上传插件
		initOrderAddFileUpload();
		//初始化类目选择和图片上传器
		TAOTAO.init({fun:function(node){
			//根据订单的分类id取订单 的规格模板，生成规格信息。第四天内容。
			TAOTAO.changeItemParam(node, "orderAddForm");
		}});
	});
	
	//提交表单
	function submitOrderAddForm(){
		//有效性验证
		if(!$('#orderAddForm').form('validate')){
			
			$.messager.alert('提示','表单还未填写完成!');
			return ;
		}
		
		
		
		//ajax的post方式提交表单
		//$("#orderAddForm").serialize()将表单序列号为key-value形式的字符串
		$.post("fileTest/insert",$("#orderAddForm").serialize(), function(data){
			if(data.status == 200){
				$.messager.alert('提示','上传成功!');
				clearOrderADDForm();
				$("#orderAddWindow").window('close');
				$(".picFileUpload").siblings("div.pics").find("ul > li").remove();
				$(".ajax-file-upload-container > .ajax-file-upload-statusbar").remove();
				$("#orderList").datagrid("reload");
			}else{
				$.messager.alert('提示',data.msg);
			}
		});
	}
	
	function clearOrderADDForm(){
		$('#orderAddForm').form('reset');
	}
</script>
