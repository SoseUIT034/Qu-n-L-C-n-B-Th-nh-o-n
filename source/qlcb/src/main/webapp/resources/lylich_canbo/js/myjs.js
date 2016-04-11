jQuery.fn.ForceNumericOnly =
function()
{
    return this.each(function () {
               $(this).keydown(function (event) {
                   // Allow: backspace, delete, tab, escape, and enter
                   if (event.keyCode == 46 || event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 27 || event.keyCode == 13 ||
                       // Allow: Ctrl+A
                       (event.keyCode == 65 && event.ctrlKey === true) ||
                       // Allow: home, end, left, right
                       (event.keyCode >= 35 && event.keyCode <= 39)) {
                       // let it happen, don't do anything
                       return;
                   } else {
                       // Ensure that it is a number and stop the keypress
                       if (event.shiftKey || (event.keyCode < 48 || event.keyCode > 57) && (event.keyCode < 96 || event.keyCode > 105)) {
                           event.preventDefault();
                       }
                   }
               });
           });
};// JavaScript Document

$(document).ready(function() {
	$.get('/qlcb/resources/lylich_canbo/js/Provinces.xml', function(d) {
		$(d).find('Item[type="province"]').each(function() {
            var $item = $(this);
			var pro = $item.attr('value');
			$(".tinhDiaChi").append($('<option>', {
				value: pro,
				text: pro
			}));
		});
	});
});

$(function() { 
	$(".datepicker").datepicker();
	$(".numberonly").ForceNumericOnly();
	$("#MaNgachList").change(function() {
		$("#MaNgach").val($("#MaNgachList").val());
		
	});
	$('.number').keypress(function(event) {
		if(event.which == 8 || event.keyCode == 37 || event.keyCode == 39 || event.keyCode == 46) 
			return true;
		else if((event.which != 46 || $(this).val().indexOf('.') != -1) && (event.which < 48 || event.which > 57))
			  event.preventDefault();

	});
	$("#fileUpload").change(function() {
		 if (this.files && this.files[0]) {
            var reader = new FileReader();            
            reader.onload = function (e) {
                $('#imgPreview').attr('src', e.target.result);
            }
            reader.readAsDataURL(this.files[0]);
        }
		});
		
	$('#noiSinhTinh').click(function(){
			$.get('/qlcb/resources/lylich_canbo/js/Provinces.xml', function(d) {
				var s = $('#noiSinhTinh').val();
				var key = 'Item[value="' + s + '"]';
				$(d).find(key).each(function() {
					var $data = $(this);
					if ($data != null) {
						$("#noiSinhHuyen").empty();
						$("#noiSinhHuyen").append($('<option>', {
							value: '',
							text: 'Chọn huyện'
						}));
					}
					$data.find('Item[type="district"]').each(function() {
                        var $dt = $(this);
						var dis = $dt.attr('value');
						
						$("#noiSinhHuyen").append($('<option>', {
							value: dis,
							text: dis
						}));
                    });
				});
			});
		});
		//$('#noiSinhTinh').change(function(){
//			$.get('Provinces.xml', function(d) {
//				var s = $('#noiSinhTinh').val();
//				var key = 'Item[value="' + s + '"]';
//				$(d).find(key).each(function() {
//					var $data = $(this);
//					if ($data != null) {
//						$("#noiSinhHuyen").empty();
//					}
//					$data.find('Item[type="district"]').each(function() {
//                        var $dt = $(this);
//						var dis = $dt.attr('value');
//						
//						$("#noiSinhHuyen").append($('<option>', {
//							value: dis,
//							text: dis
//						}));
//                    });
//				});
//			});
//		});

	$('#noiSinhHuyen').click(function() {
		$.get('/qlcb/resources/lylich_canbo/js/Provinces.xml', function(d) {
				var s = $('#noiSinhHuyen').val();
				var key = 'Item[value="' + s + '"]';
				$(d).find(key).each(function() {
					var $data = $(this);
					if ($data != null) {
						$("#noiSinhXa").empty();
						$("#noiSinhXa").append($('<option>', {
							value: '',
							text: 'Chọn xã'
						}));
					}
					$data.find('Item[type="precinct"]').each(function() {
                        var $dt = $(this);
						var dis = $dt.attr('value');
						
						$("#noiSinhXa").append($('<option>', {
							value: dis,
							text: dis
						}));
                    });
				});
			});
		});
		
	$('#queQuanTinh').click(function(){
			$.get('/qlcb/resources/lylich_canbo/js/Provinces.xml', function(d) {
				var s = $('#queQuanTinh').val();
				var key = 'Item[value="' + s + '"]';
				$(d).find(key).each(function() {
					var $data = $(this);
					if ($data != null) {
						$("#queQuanHuyen").empty();
						$("#queQuanHuyen").append($('<option>', {
							value: '',
							text: 'Chọn huyện'
						}));
					}
					$data.find('Item[type="district"]').each(function() {
                        var $dt = $(this);
						var dis = $dt.attr('value');
						
						$("#queQuanHuyen").append($('<option>', {
							value: dis,
							text: dis
						}));
                    });
				});
			});
		});
				
	$('#queQuanHuyen').click(function() {
		$.get('/qlcb/resources/lylich_canbo/js/Provinces.xml', function(d) {
				var s = $('#queQuanHuyen').val();
				var key = 'Item[value="' + s + '"]';
				$(d).find(key).each(function() {
					var $data = $(this);
					if ($data != null) {
						$("#queQuanXa").empty();
						$("#queQuanXa").append($('<option>', {
							value: '',
							text: 'Chọn xã'
						}));
					}
					$data.find('Item[type="precinct"]').each(function() {
                        var $dt = $(this);
						var dis = $dt.attr('value');
						
						$("#queQuanXa").append($('<option>', {
							value: dis,
							text: dis
						}));
                    });
				});
			});
		});
	
});
