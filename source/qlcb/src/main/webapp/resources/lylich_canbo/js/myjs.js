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
	$('.datepicker').datepicker();
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
	
	
		  
          /* var reader = new FileReader(); 
           reader.readAsDataURL($('#imgpreview').attr('src'));
           
           $('#imgpreview').attr('src', e.target.result);*/
			/*if($('#imgpreview').attr('src')!=null)
				{
				 	 var temp = url.format(url.parse('file://' +$('#imgpreview').attr('src')));
					 $('#imgpreview').attr('src', temp);
				}*/
           
           $("#fileLTN").change(function() {
      		 if (this.files && this.files[0]) {
                  var reader = new FileReader();            
                  reader.onload = function (e) {
                      $('#imgpreview').attr('src', e.target.result);
                  }
                  reader.readAsDataURL(this.files[0]);
              }
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
	
		$('#tbodyDTBD').append('<tr><td><input type="text" class="form-control" id="tttxt1" name="tttxt1"/></td><td><input type="text" class="form-control" id="cndtbdtxt1" name="cndtbdtxt1"/></td><td><input class="form-control datepicker" type="date-time" id="dtbdttntxt1" name="dtbdttntxt"/></td><td><input class="form-control datepicker" type="date-time" id="dtbddtntxt1" name="dtbddtntxt1"/></td><td style="display:none"><input style="display:none" value="-111" class="form-control" type="text" id="id" name="id"/></td><td><select class="form-control" id="htdtsel1" name="htdtsel1"><option value="Chính quy">Chính quy</option><option value="Tại chức">Tại chức</option><option value="Chuyên tu">Chuyên tu</option><option value="Bồi dưỡng">Bồi dưỡng</option></select></td><td><select class="form-control" id="vbcctdsel1" name="vbcctdsel1"><option value="Tiến sĩ khoa học">Tiến sĩ khoa học</option><option value="Tiến sĩ">Tiến sĩ</option><option value="Thạc sĩ">Thạc sĩ</option><option value="Cử nhân">Cử nhân</option><option value="Kỹ sư">Kỹ sư</option></select></td><td><button class="btn btn-default" type="button" onClick=\'deleteRowDTBD(this, "tableDTBD")\'><span class="glyphicon glyphicon-trash" aria-hidden="true"> Xóa</span></button></td>');
		var i = 0;
		$('#tbodyDTBD tr').each(function() {
			var $tr = $(this);
			// input
			$tr.find('input').get(0).setAttribute('id', 'ldtcm['+i+'].truong');
			$tr.find('input').get(0).setAttribute('name', 'ldtcm['+i+'].truong');
			$tr.find('input').get(1).setAttribute('id', 'ldtcm['+i+'].chuyenNganhDaoTao');
			$tr.find('input').get(1).setAttribute('name', 'ldtcm['+i+'].chuyenNganhDaoTao');
			$tr.find('input').get(2).setAttribute('id', 'ldtcm['+i+'].tuNgay');
			$tr.find('input').get(2).setAttribute('name', 'ldtcm['+i+'].tuNgay');
			$tr.find('input').get(3).setAttribute('id', 'ldtcm['+i+'].toiNgay');
			$tr.find('input').get(3).setAttribute('name', 'ldtcm['+i+'].toiNgay');
			$tr.find('input').get(4).setAttribute('id', 'ldtcm['+i+'].maDaoTao');		//hide
			$tr.find('input').get(4).setAttribute('name', 'ldtcm['+i+'].maDaoTao');		//hide
			// select
			$tr.find('select').get(0).setAttribute('id', 'ldtcm['+i+'].hinhThucDaoTao');
			$tr.find('select').get(0).setAttribute('name', 'ldtcm['+i+'].hinhThucDaoTao');
			$tr.find('select').get(1).setAttribute('id', 'ldtcm['+i+'].chungChiDatDuoc');
			$tr.find('select').get(1).setAttribute('name', 'ldtcm['+i+'].chungChiDatDuoc');
			i++;
        });
		$('.datepicker').datepicker(); 
	});
	$('#themQTCT').click(function() {
		$('#tbodyQTCT').append('<tr><td><input class="form-control datepicker" type="date-time" id="ttqtctttntxt1" name="ttqtctttntxt1"/></td><td><input class="form-control datepicker" type="date-time" id="ttqtctttntxt1" name="ttqtctttntxt1"/></td><td><input class="form-control " type="text" id="ttqtctttntxt1" name="ttqtctttntxt1"/></td><td style="display:none"><input style="display:none" value="-111" class="form-control " type="text" id="id" name="id"/></td><td><button class="btn btn-default" type="button" onClick=\'deleteRowQTCT(this, "tableQTCT")\'><span class="glyphicon glyphicon-trash" aria-hidden="true"> Xóa</span></button></td>');	
		var i = 0;
		$('#tbodyQTCT tr').each(function() {
			var $tr = $(this);
			// input
			$tr.find('input').get(0).setAttribute('id', 'lsct['+i+'].tuNgay');
			$tr.find('input').get(0).setAttribute('name', 'lsct['+i+'].tuNgay');
			$tr.find('input').get(1).setAttribute('id', 'lsct['+i+'].toiNgay');
			$tr.find('input').get(1).setAttribute('name', 'lsct['+i+'].toiNgay');
			$tr.find('input').get(2).setAttribute('id', 'lsct['+i+'].chucVu');
			$tr.find('input').get(2).setAttribute('name', 'lsct['+i+'].chucVu');
			$tr.find('input').get(3).setAttribute('id', 'lsct['+i+'].maLsct');		//hide
			$tr.find('input').get(3).setAttribute('name', 'lsct['+i+'].].maLsct');	//hide
			i++;
        });
		$('.datepicker').datepicker();	
	});
	
	$('#themVBT').click(function(){
		$('#tbodyVBT').append('<tr><td><input type="text" class="form-control" id="mqhbttxt1" name="mqhbttxt1"/></td><td><input type="text" class="form-control" id="httbtxt1" name="htbttxt1"/></td><td><input class="form-control datepicker" type="date-time" id="nsbttxt1" name="nstxt1"/></td><td><input class="form-control" type="text" id="qqnncdbttxt1" name="qqnncdbttxt1"/></td><td style="display:none"><input style="display:none"  value="-111" class="form-control" type="text" id="id" name="id"/></td><td><button class="btn btn-default" type="button" onClick=\'deleteRowVBT(this, "tableVBT")\'><span class="glyphicon glyphicon-trash" aria-hidden="true"> Xóa</span></button></td>');	
		var i = 0;
		$('#tbodyVBT tr').each(function() {
			var $tr = $(this);
			// input
			$tr.find('input').get(0).setAttribute('id',  'lqhbt['+i+'].quanHe');
			$tr.find('input').get(0).setAttribute('name', 'lqhbt['+i+'].quanHe');
			$tr.find('input').get(1).setAttribute('id', 'lqhbt['+i+'].hoTen');
			$tr.find('input').get(1).setAttribute('name', 'lqhbt['+i+'].hoTen');
			$tr.find('input').get(2).setAttribute('id', 'lqhbt['+i+'].ngaySinh');
			$tr.find('input').get(2).setAttribute('name', 'lqhbt['+i+'].ngaySinh');
			$tr.find('input').get(3).setAttribute('id', 'lqhbt['+i+'].ghiChu');
			$tr.find('input').get(3).setAttribute('name', 'lqhbt['+i+'].ghiChu');		
			$tr.find('input').get(4).setAttribute('id', 'lqhbt['+i+'].id');			//hide
			$tr.find('input').get(4).setAttribute('name', 'lqhbt['+i+'].id');		//hide	
			i++;
        });
		$('.datepicker').datepicker();	
	});
	$('#themVBV').click(function(){
		$('#tbodyVBV').append('<tr><td><input type="text" class="form-control" id="mqhbvtxt1" name="mqhbvtxt1" /></td><td><input type="text" class="form-control" id="htbvtxt1" name="htbvtxt1"/></td><td><input class="form-control datepicker" type="date-time" id="nsbvtxt" name="nsbvtxt1"/></td><td><input class="form-control" type="text" id="qqnncdbvtxt1" name="qqnncdbvtxt1"/></td><td style="display:none"><input style="display:none" value="-111" class="form-control" type="text" id="id" name="id"/></td><td><button class="btn btn-default" type="button" onClick=\'deleteRowVBV(this, "tableVBV")\'><span class="glyphicon glyphicon-trash" aria-hidden="true"> Xóa</span></button></td>');	
		var i = 0;
		$('#tbodyVBV tr').each(function() {
			var $tr = $(this);
			// input lqhdt
			$tr.find('input').get(0).setAttribute('id', 'lqhdt['+i+'].quanHe');
			$tr.find('input').get(0).setAttribute('name','lqhdt['+i+'].quanHe');
			$tr.find('input').get(1).setAttribute('id', 'lqhdt['+i+'].hoTen');
			$tr.find('input').get(1).setAttribute('name', 'lqhdt['+i+'].hoTen');
			$tr.find('input').get(2).setAttribute('id', 'lqhdt['+i+'].ngaySinh');
			$tr.find('input').get(2).setAttribute('name', 'lqhdt['+i+'].ngaySinh');
			$tr.find('input').get(3).setAttribute('id', 'lqhdt['+i+'].ghiChu');
			$tr.find('input').get(3).setAttribute('name', 'lqhdt['+i+'].ghiChu');	
			$tr.find('input').get(4).setAttribute('id', 'lqhdt['+i+'].id');			//hide
			$tr.find('input').get(4).setAttribute('name', 'lqhdt['+i+'].id');		//hide	
			i++;
        });
		$('.datepicker').datepicker();
	});
	$('#themDBL').click(function() {
		$('#tbodyDBL').append('<tr><td><input class="form-control datepicker-month" id="tndblcbtxt1" name="tndblcbtxt1"/></td><td><input class="form-control number" id="mnbdbltxt1" name="mbdbltxt1"/></td><td><input class="form-control number" id="hsldbltxt1" name="hsldbltxt1"/></td><td style="display:none"><input style="display:none" value="-111" class="form-control" type="text" id="id" name="id"/></td><td><button class="btn btn-default" type="button" onClick=\'deleteRowDBL(this, "tableDBL")\'><span class="glyphicon glyphicon-trash" aria-hidden="true"> Xóa</span></button></td>');
		var i = 0;
		$('#tbodyDBL tr').each(function() {
			var $tr = $(this);
			// input
			$tr.find('input').get(0).setAttribute('id', 'ldbl['+i+'].lngaythang');
			$tr.find('input').get(0).setAttribute('name', 'ldbl['+i+'].lngaythang');
			$tr.find('input').get(1).setAttribute('id', 'ldbl['+i+'].lmangach_bac');
			$tr.find('input').get(1).setAttribute('name', 'ldbl['+i+'].lmangach_bac');
			$tr.find('input').get(2).setAttribute('id', 'ldbl['+i+'].heSoLuong');
			$tr.find('input').get(2).setAttribute('name', 'ldbl['+i+'].heSoLuong');	
			$tr.find('input').get(3).setAttribute('id', 'ldbl['+i+'].id');
			$tr.find('input').get(3).setAttribute('name', 'ldbl['+i+'].id');	
			i++;
        });
		$('.datepicker-month').datepicker();
	});
});

function deleteRowDTBD(r, id) {
    var i = r.parentNode.parentNode.rowIndex;
    document.getElementById(id).deleteRow(i);
	var i = 0;
		$('#tbodyDTBD tr').each(function() {
			var $tr = $(this);
			// input
			$tr.find('input').get(0).setAttribute('id', 'ldtcm['+i+'].truong');
			$tr.find('input').get(0).setAttribute('name', 'ldtcm['+i+'].truong');
			$tr.find('input').get(1).setAttribute('id', 'ldtcm['+i+'].chuyenNganhDaoTao');
			$tr.find('input').get(1).setAttribute('name', 'ldtcm['+i+'].chuyenNganhDaoTao');
			$tr.find('input').get(2).setAttribute('id', 'ldtcm['+i+'].tuNgay');
			$tr.find('input').get(2).setAttribute('name', 'ldtcm['+i+'].tuNgay');
			$tr.find('input').get(3).setAttribute('id', 'ldtcm['+i+'].toiNgay');
			$tr.find('input').get(3).setAttribute('name', 'ldtcm['+i+'].toiNgay');
			$tr.find('input').get(4).setAttribute('id', 'ldtcm['+i+'].maDaoTao');		//hide
			$tr.find('input').get(4).setAttribute('name', 'ldtcm['+i+'].maDaoTao');		//hide
			// select
			$tr.find('select').get(0).setAttribute('id', 'ldtcm['+i+'].hinhThucDaoTao');
			$tr.find('select').get(0).setAttribute('name', 'ldtcm['+i+'].hinhThucDaoTao');
			$tr.find('select').get(1).setAttribute('id', 'ldtcm['+i+'].chungChiDatDuoc');
			$tr.find('select').get(1).setAttribute('name', 'ldtcm['+i+'].chungChiDatDuoc');
			i++;
        });
		$('.datepicker').datepicker(); 
}
function deleteRowQTCT(r, id) {
    var i = r.parentNode.parentNode.rowIndex;
    document.getElementById(id).deleteRow(i);
	var i = 0;
		$('#tbodyQTCT tr').each(function() {
			var $tr = $(this);
			// input
			$tr.find('input').get(0).setAttribute('id', 'lsct['+i+'].tuNgay');
			$tr.find('input').get(0).setAttribute('name', 'lsct['+i+'].tuNgay');
			$tr.find('input').get(1).setAttribute('id', 'lsct['+i+'].toiNgay');
			$tr.find('input').get(1).setAttribute('name', 'lsct['+i+'].toiNgay');
			$tr.find('input').get(2).setAttribute('id', 'lsct['+i+'].chucVu');
			$tr.find('input').get(2).setAttribute('name', 'lsct['+i+'].chucVu');
			$tr.find('input').get(3).setAttribute('id', 'lsct['+i+'].maLsct');		//hide
			$tr.find('input').get(3).setAttribute('name', 'lsct['+i+'].].maLsct');	//hide
			i++;
        });
		$('.datepicker').datepicker();	
}
function deleteRowVBT(r, id) {
    var i = r.parentNode.parentNode.rowIndex;
    document.getElementById(id).deleteRow(i);
	var i = 0;
		$('#tbodyVBT tr').each(function() {
			var $tr = $(this);
			// input
			$tr.find('input').get(0).setAttribute('id',  'lqhbt['+i+'].quanHe');
			$tr.find('input').get(0).setAttribute('name', 'lqhbt['+i+'].quanHe');
			$tr.find('input').get(1).setAttribute('id', 'lqhbt['+i+'].hoTen');
			$tr.find('input').get(1).setAttribute('name', 'lqhbt['+i+'].hoTen');
			$tr.find('input').get(2).setAttribute('id', 'lqhbt['+i+'].ngaySinh');
			$tr.find('input').get(2).setAttribute('name', 'lqhbt['+i+'].ngaySinh');
			$tr.find('input').get(3).setAttribute('id', 'lqhbt['+i+'].ghiChu');
			$tr.find('input').get(3).setAttribute('name', 'lqhbt['+i+'].ghiChu');		
			$tr.find('input').get(4).setAttribute('id', 'lqhbt['+i+'].id');			//hide
			$tr.find('input').get(4).setAttribute('name', 'lqhbt['+i+'].id');		//hide	
			i++;
        });
		$('.datepicker').datepicker();
}
function deleteRowVBV(r, id) {
    var i = r.parentNode.parentNode.rowIndex;
    document.getElementById(id).deleteRow(i);
	var i = 0;
		$('#tbodyVBV tr').each(function() {
			var $tr = $(this);
			// input lqhdt
			$tr.find('input').get(0).setAttribute('id', 'lqhdt['+i+'].quanHe');
			$tr.find('input').get(0).setAttribute('name','lqhdt['+i+'].quanHe');
			$tr.find('input').get(1).setAttribute('id', 'lqhdt['+i+'].hoTen');
			$tr.find('input').get(1).setAttribute('name', 'lqhdt['+i+'].hoTen');
			$tr.find('input').get(2).setAttribute('id', 'lqhdt['+i+'].ngaySinh');
			$tr.find('input').get(2).setAttribute('name', 'lqhdt['+i+'].ngaySinh');
			$tr.find('input').get(3).setAttribute('id', 'lqhdt['+i+'].ghiChu');
			$tr.find('input').get(3).setAttribute('name', 'lqhdt['+i+'].ghiChu');	
			$tr.find('input').get(4).setAttribute('id', 'lqhdt['+i+'].id');			//hide
			$tr.find('input').get(4).setAttribute('name', 'lqhdt['+i+'].id');		//hide	
			i++;
        });
		$('.datepicker').datepicker();
}
function deleteRowDBL(r, id) {
    var i = r.parentNode.parentNode.rowIndex;
    document.getElementById(id).deleteRow(i);
	var i = 0;
		$('#tbodyDBL tr').each(function() {
			var $tr = $(this);
			// input
			$tr.find('input').get(0).setAttribute('id', 'ldbl['+i+'].lngaythang');
			$tr.find('input').get(0).setAttribute('name', 'ldbl['+i+'].lngaythang');
			$tr.find('input').get(1).setAttribute('id', 'ldbl['+i+'].lmangach_bac');
			$tr.find('input').get(1).setAttribute('name', 'ldbl['+i+'].lmangach_bac');
			$tr.find('input').get(2).setAttribute('id', 'ldbl['+i+'].heSoLuong');
			$tr.find('input').get(2).setAttribute('name', 'ldbl['+i+'].heSoLuong');	
			$tr.find('input').get(3).setAttribute('id', 'ldbl['+i+'].id');
			$tr.find('input').get(3).setAttribute('name', 'ldbl['+i+'].id');
			i++;
        });
		$('.datepicker-month').datepicker();
}

