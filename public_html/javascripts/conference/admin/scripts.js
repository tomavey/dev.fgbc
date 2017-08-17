$(document).ready(function () {

        //hide the discount options section
        $("#discountOptions").hide();

        //Set some instructions for later use
        var maxtext = "Enter the option name that the 'maximum' discount will be applied to.  Can only be one option name (ie:VConfCouple)";

        var percenttext = "Enter the option name that the 'percent' discount will be applied to.  Can only be one option name (ie:VConfCouple)";

        var dollartext = "Comma delimited list of option names that this discount depends on. (ie: If this discount can only be used with a full registration enter 'V2020RegCouple,V2020RegSingle'.) If this discount does not depend on a specific option, leave blank.";

        var $discountType = $("select#option-discountType").val();


        //When editing existing record, show the correct sections and intructions
        if ($("select#option-type").val() == "Discount") {
            $("#discountOptions").show();
        };

        if($discountType == "maximum") {
             $("#discountinstructions").text(maxtext);
        }
        else if ($discountType == "percent") {
             $("#discountinstructions").text(percenttext);
        }
        else if ($discountType = "dollar") {
             $("#discountinstructions").text(dollartext);
        }

        if($("select#option-type").val == "Select quantity from list"){
                    $("#discountOptions").show();
        }

        //Change discount instructions for each discount type
        $("select#option-discountType").trigger("change");
        $("select#option-discountType").change(function(){
                var str = $("select#option-discountType").val();
                if (str == "maximum") {
                    $("#discountinstructions").text(maxtext);
                }
                else if (str == "percent")
                {
                    $("#discountinstructions").text(percenttext);
                }
                else if (str = "dollar"){
                    $("#discountinstructions").text(dollartext);
                }
                ;
        });

        //Show the discount block when option type is discount
        $("select#option-type").trigger("change");
         $("select#option-type").change(function(){
                var str = $("select#option-type").val();
                if (str == "Discount"){
                    $("#discountOptions").show();
                }
                else {
                    $("#discountOptions").hide();
                }
                ;
         });

         //Show the number of options to show when select quantity from list
         $("#selectquantitymax").hide()
         $("select#option-buttontype").trigger("change");
         $("select#option-buttontype").change(function(){
            var str = $("select#option-buttontype").val();
            console.log(str);
            if (str == "Select quantity from list") {
                 $("#selectquantitymax").show()
            }
            else {
                 $("#selectquantitymax").hide()
            };
         })
})

