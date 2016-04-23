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
	$.get('Provinces.xml', function(d) {
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
	$('.datepicker-month').datepicker({
        changeMonth: true,
        changeYear: true,
		showButtonPanel: true,
		dateFormat: 'MM yy',
    });
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
	$("#fileupload").change(function() {
		 if (this.files && this.files[0]) {
            var reader = new FileReader();            
            reader.onload = function (e) {
                $('#imgpreview').attr('src', e.target.result);
            }
            reader.readAsDataURL(this.files[0]);
        }
		});
		
	$('#noisinhtinh').click(function(){
			$.get('Provinces.xml', function(d) {
				var s = $('#noisinhtinh').val();
				var key = 'Item[value="' + s + '"]';
				$(d).find(key).each(function() {
					var $data = $(this);
					if ($data != null) {
						$("#noisinhhuyen").empty();
						$("#noisinhhuyen").append($('<option>', {
							value: '',
							text: 'Chọn huyện'
						}));
					}
					$data.find('Item[type="district"]').each(function() {
                        var $dt = $(this);
						var dis = $dt.attr('value');
						
						$("#noisinhhuyen").append($('<option>', {
							value: dis,
							text: dis
						}));
                    });
				});
			});
		});
		//$('#noisinhtinh').change(function(){
//			$.get('Provinces.xml', function(d) {
//				var s = $('#noisinhtinh').val();
//				var key = 'Item[value="' + s + '"]';
//				$(d).find(key).each(function() {
//					var $data = $(this);
//					if ($data != null) {
//						$("#noisinhhuyen").empty();
//					}
//					$data.find('Item[type="district"]').each(function() {
//                        var $dt = $(this);
//						var dis = $dt.attr('value');
//						
//						$("#noisinhhuyen").append($('<option>', {
//							value: dis,
//							text: dis
//						}));
//                    });
//				});
//			});
//		});

	$('#noisinhhuyen').click(function() {
		$.get('Provinces.xml', function(d) {
				var s = $('#noisinhhuyen').val();
				var key = 'Item[value="' + s + '"]';
				$(d).find(key).each(function() {
					var $data = $(this);
					if ($data != null) {
						$("#noisinhxa").empty();
						$("#noisinhxa").append($('<option>', {
							value: '',
							text: 'Chọn xã'
						}));
					}
					$data.find('Item[type="precinct"]').each(function() {
                        var $dt = $(this);
						var dis = $dt.attr('value');
						
						$("#noisinhxa").append($('<option>', {
							value: dis,
							text: dis
						}));
                    });
				});
			});
		});
		
	$('#quequantinh').click(function(){
			$.get('Provinces.xml', function(d) {
				var s = $('#quequantinh').val();
				var key = 'Item[value="' + s + '"]';
				$(d).find(key).each(function() {
					var $data = $(this);
					if ($data != null) {
						$("#quequanhuyen").empty();
						$("#quequanhuyen").append($('<option>', {
							value: '',
							text: 'Chọn huyện'
						}));
					}
					$data.find('Item[type="district"]').each(function() {
                        var $dt = $(this);
						var dis = $dt.attr('value');
						
						$("#quequanhuyen").append($('<option>', {
							value: dis,
							text: dis
						}));
                    });
				});
			});
		});
				
	$('#quequanhuyen').click(function() {
		$.get('Provinces.xml', function(d) {
				var s = $('#quequanhuyen').val();
				var key = 'Item[value="' + s + '"]';
				$(d).find(key).each(function() {
					var $data = $(this);
					if ($data != null) {
						$("#quequanxa").empty();
						$("#quequanxa").append($('<option>', {
							value: '',
							text: 'Chọn xã'
						}));
					}
					$data.find('Item[type="precinct"]').each(function() {
                        var $dt = $(this);
						var dis = $dt.attr('value');
						
						$("#quequanxa").append($('<option>', {
							value: dis,
							text: dis
						}));
                    });
				});
			});
		});
	$('#themDTBD').click(function() {
		$('#tbodyDTBD').append('<tr><td><input type="text" class="form-control" id="tttxt1" name="tttxt1"/></td><td><input type="text" class="form-control" id="cndtbdtxt1" name="cndtbdtxt1"/></td><td><input class="form-control datepicker" type="date" id="dtbdttntxt1" name="dtbdttntxt"/></td><td><input class="form-control datepicker" type="date" id="dtbddtntxt1" name="dtbddtntxt1"/></td><td><select class="form-control" id="htdtsel1" name="htdtsel1"><option value="Chính quy">Chính quy</option><option value="Tại chức">Tại chức</option><option value="Chuyên tu">Chuyên tu</option><option value="Bồi dưỡng">Bồi dưỡng</option></select></td><td><select class="form-control" id="vbcctdsel1" name="vbcctdsel1"><option value="Tiến sĩ khoa học">Tiến sĩ khoa học</option><option value="Tiến sĩ">Tiến sĩ</option><option value="Thạc sĩ">Thạc sĩ</option><option value="Cử nhân">Cử nhân</option><option value="Kỹ sư">Kỹ sư</option></select></td><td><button class="btn btn-default" type="button" onClick=\'deleteRow(this, "tableDTBD")\'><span class="glyphicon glyphicon-trash" aria-hidden="true"> Xóa</span></button></td>');
		var i = 1;
		$('#tbodyDTBD tr').each(function() {
			var $tr = $(this);
			// input
			$tr.find('input').get(0).setAttribute('id', 'tttxt' + i);
			$tr.find('input').get(0).setAttribute('name', 'tttxt' + i);
			$tr.find('input').get(1).setAttribute('id', 'cndtbdtxt' + i);
			$tr.find('input').get(1).setAttribute('name', 'cndtbdtxt' + i);
			$tr.find('input').get(2).setAttribute('id', 'dtbdttntxt' + i);
			$tr.find('input').get(2).setAttribute('nam', 'dtbdttntxt' + i);
			$tr.find('input').get(3).setAttribute('id', 'dtbddtntxt' + i);
			$tr.find('input').get(3).setAttribute('name', 'dtbddtntxt' + i);
			// select
			$tr.find('select').get(0).setAttribute('id', 'htdtsel' + i);
			$tr.find('select').get(0).setAttribute('name', 'htdtsel' + i);
			$tr.find('select').get(1).setAttribute('id', 'vbcctdsel' + i);
			$tr.find('select').get(1).setAttribute('name', 'vbcctdsel' + i);
			i++;
        });
		$('.datepicker').datepicker();
	});
	$('#themQTCT').click(function() {
		//$('#tbodyQTCT').append('<tr><td><form:input path="canboByMaCanBo.congtacnuocngoais[].tuNgay" class="form-control datepicker" type="date" id="ttqtctttntxt1" name="ttqtctttntxt1"/></td><td><input class="form-control datepicker" type="date" id="ttqtctdtntxt1" name="ttqtctdtntxt1"/></td><td><input class="form-control" type="text" id="cdcvdvtxt1" name="cdcvdvtxt1"/></td><td><button class="btn btn-default" type="button" onClick=\'deleteRow(this, "tableQTCT")\'><span class="glyphicon glyphicon-trash" aria-hidden="true"> Xóa</span></button></td>');	
		var i = 1;
		$('#tbodyQTCT tr').each(function() {
			var $tr = $(this);
			// input
			$tr.find('input').get(0).setAttribute('id', 'ttqtctttntxt' + i);
			$tr.find('input').get(0).setAttribute('name', 'ttqtctttntxt' + i);
			$tr.find('input').get(1).setAttribute('id', 'ttqtctdtntxt' + i);
			$tr.find('input').get(1).setAttribute('name', 'ttqtctdtntxt' + i);
			$tr.find('input').get(2).setAttribute('id', 'cdcvdvtxt' + i);
			$tr.find('input').get(2).setAttribute('nam', 'cdcvdvtxt' + i);
			i++;
        });
		$('.datepicker').datepicker();	
		$('#tbodyQTCT').append('<tr><td><form:input path="canboByMaCanBo.congtacnuocngoais['+(i-1)+'].tuNgay" class="form-control datepicker" type="date" id="ttqtctttntxt1" name="ttqtctttntxt1"/></td><td><input class="form-control datepicker" type="date" id="ttqtctdtntxt1" name="ttqtctdtntxt1"/></td><td><input class="form-control" type="text" id="cdcvdvtxt1" name="cdcvdvtxt1"/></td><td><button class="btn btn-default" type="button" onClick=\'deleteRow(this, "tableQTCT")\'><span class="glyphicon glyphicon-trash" aria-hidden="true"> Xóa</span></button></td>');	
	});
	
	$('#themVBT').click(function(){
		$('#tbodyVBT').append('<tr><td><input type="text" class="form-control" id="mqhbttxt1" name="mqhbttxt1"/></td><td><input type="text" class="form-control" id="httbtxt1" name="htbttxt1"/></td><td><input class="form-control datepicker" type="date" id="nsbttxt1" name="nstxt1"/></td><td><input class="form-control" type="text" id="qqnncdbttxt1" name="qqnncdbttxt1"/></td><td><button class="btn btn-default" type="button" onClick=\'deleteRow(this, "tableVBT")\'><span class="glyphicon glyphicon-trash" aria-hidden="true"> Xóa</span></button></td>');	
		var i = 1;
		$('#tbodyVBT tr').each(function() {
			var $tr = $(this);
			// input
			$tr.find('input').get(0).setAttribute('id', 'mqhbttxt' + i);
			$tr.find('input').get(0).setAttribute('name', 'mqhbttxt' + i);
			$tr.find('input').get(1).setAttribute('id', 'httbtxt' + i);
			$tr.find('input').get(1).setAttribute('name', 'httbtxt' + i);
			$tr.find('input').get(2).setAttribute('id', 'nsbttxt' + i);
			$tr.find('input').get(2).setAttribute('nam', 'nsbttxt' + i);
			$tr.find('input').get(3).setAttribute('id', 'qqnncdbttxt' + i);
			$tr.find('input').get(3).setAttribute('name', 'qqnncdbttxt' + i);			
			i++;
        });
		$('.datepicker').datepicker();
	});
	$('#themVBV').click(function(){
		$('#tbodyVBV').append('<tr><td><input type="text" class="form-control" id="mqhbvtxt1" name="mqhbvtxt1" /></td><td><input type="text" class="form-control" id="htbvtxt1" name="htbvtxt1"/></td><td><input class="form-control datepicker" type="date" id="nsbvtxt" name="nsbvtxt1"/></td><td><input class="form-control" type="text" id="qqnncdbvtxt1" name="qqnncdbvtxt1"/></td><td><button class="btn btn-default" type="button" onClick=\'deleteRow(this, "tableVBV")\'><span class="glyphicon glyphicon-trash" aria-hidden="true"> Xóa</span></button></td>');	
		var i = 1;
		$('#tbodyVBV tr').each(function() {
			var $tr = $(this);
			// input
			$tr.find('input').get(0).setAttribute('id', 'mqhbvtxt' + i);
			$tr.find('input').get(0).setAttribute('name', 'mqhbvtxt' + i);
			$tr.find('input').get(1).setAttribute('id', 'htbvtxt' + i);
			$tr.find('input').get(1).setAttribute('name', 'htbvtxt' + i);
			$tr.find('input').get(2).setAttribute('id', 'nsbvtxt' + i);
			$tr.find('input').get(2).setAttribute('nam', 'nsbvtxt' + i);
			$tr.find('input').get(3).setAttribute('id', 'qqnncdbvtxt' + i);
			$tr.find('input').get(3).setAttribute('name', 'qqnncdbvtxt' + i);			
			i++;
        });
		$('.datepicker').datepicker();
	});
	$('#themDBL').click(function() {
		$('#tbodyDBL').append('<tr><td><input class="form-control datepicker-month" id="tndblcbtxt1" name="tndblcbtxt1"/></td><td><input class="form-control number" id="mnbdbltxt1" name="mbdbltxt1"/></td><td><input class="form-control number" id="hsldbltxt1" name="hsldbltxt1"/></td><td><button class="btn btn-default" type="button" onClick=\'deleteRow(this, "tableDBL")\'><span class="glyphicon glyphicon-trash" aria-hidden="true"> Xóa</span></button></td>');
		var i = 1;
		$('#tbodyDBL tr').each(function() {
			var $tr = $(this);
			// input
			$tr.find('input').get(0).setAttribute('id', 'tndblcbtxt' + i);
			$tr.find('input').get(0).setAttribute('name', 'tndblcbtxt' + i);
			$tr.find('input').get(1).setAttribute('id', 'mbdbltxt' + i);
			$tr.find('input').get(1).setAttribute('name', 'mbdbltxt' + i);
			$tr.find('input').get(2).setAttribute('id', 'hsldbltxt' + i);
			$tr.find('input').get(2).setAttribute('nam', 'hsldbltxt' + i);		
			i++;
        });
		$('.datepicker-month').datepicker();
	});
});

function deleteRow(r, id) {
    var i = r.parentNode.parentNode.rowIndex;
    document.getElementById(id).deleteRow(i);
}

