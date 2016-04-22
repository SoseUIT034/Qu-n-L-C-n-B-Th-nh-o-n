
 
$(document).ready(function () {
    $("#luuButton").on("click", clickok);



})


function clickok() {
    var r=[];
    var rowitem = $("#tbodyQTCT").find("tr");
    $.each(rowitem, function(index, item){
    	
    	var ngaydb = $(item).find("#ttqtctttntxt1").val();
        var rid = $(item).find(".rowid").text().trim();
        var rname = $(item).find(".rowname").text().trim();
        var rquatity = $(item).find(".rowquantity").find(".form-control").val().trim();
        r.push({
            id: rid,
            quatity: rquatity,
            })

         

    })
     
   
    $.ajax({
        url: "/Cart/CheckIteminCart",
        data: { data: JSON.stringify( r) },
        datatype: 'Json',
        type: 'post',
        success: function (result) {
            
            result=result.substring(1, result.length - 1);
            result ="'"+ result+"'";

            var flag = 0;
            var obj = JSON.parse(result);
            $.each(obj, function (index, item) {

                if(item.key==0)
                {
                    $("#" + item.id).attr('background','red');
                    flag = 1;
                }


            })
            

        }



    })
    }

