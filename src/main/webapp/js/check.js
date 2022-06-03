function checkPassword(){
    let password1=$("#user_password").val();
    let password2=$("#user_password_2").val();
    if(password1===password2){
        $("#msg").html("Password matches").removeClass("text-danger").addClass("text-success");
    }
    else{
        $("#msg").html("Password doesn't match").removeClass("text-success").addClass("text-danger")
    }
}

//printing message on register page using ajax
$(document).ready(function () {
    $("#myform").on('submit', function (event) {
        //when a  form is submitted it will defaulty go RegisterServlet the below function will prevent the default function and execute the below function
        event.preventDefault();
        $(".sub-btn").hide();
        $(".loader").show();


        //getting data of form;
        // let f = $("#myform").serialize();
        let f=new FormData(this);
        console.log(f);


        //ajax request
        $.ajax({
            url: "RegisterServlet", //the url of servlet
            type: 'POST',
            data: f, //data to pass

            //on success
            success: function (data, textStatus, jqXHR) {
                if(data.trim()=="Succesfully Registered..") {
                    $("#msg_header").html(data).removeClass("text-danger").addClass("text-success");

                    /*sweet alert for that we use swal sweet alert is just for good design*/
                    swal("Registered Succesfully..", "we are redirecting to login page", "success")
                        .then((value) => {
                            window.location = "login.jsp";
                        });
                }
                else{
                    $("#msg_header").html(data).removeClass("text-success").addClass("text-danger");
                    swal("Please accept terms and Conditions","","info")

                }
                $(".sub-btn").show();
                $(".loader").hide();

            },
            error: function (jqXHR, textStatus, errorThrown) {
                // console.log(data);
                swal("Something went wrong..","","error")
                $("#msg_header").html("something went wrong").removeClass("text-success").addClass("text-danger");
                $(".sub-btn").show();
                $(".loader").hide();
            },
            processData: false,
            contentType: false,
        })
    })
})

//login check ajax
$("document").ready(function (){
    $("#login_from").on('submit',function (event){
        event.preventDefault();
        let d=new FormData(this);
        console.log(d);

        //ajax request to login Servlet class
        $.ajax({
            url:"LoginServlet",
            type: 'POST',
            data:d,
            success:function (data,textStatus,jqXHR) {
                if(data.trim()=="Password Doesn't Match" ){
                    // $("#login_msg").html(data).addClass("text-danger").removeClass("text-success");
                    swal("Password Doesn't Match", "", "error")
                        .then((value) => {
                            window.location = "login.jsp";
                        });
                }
                else if(data.trim()=="You Have not registered"){
                    // $("#login_msg").html(data).addClass("text-danger").removeClass("text-success");
                    swal("You Have not registered", "we are redirecting to register page", "error")
                        .then((value) => {
                            window.location = "register.jsp";
                        });
                }
                else{
                    // $("#login_msg").html(data).addClass("text-success").removeClass("text-danger");
                    swal("Successfully logged in..", "we are redirecting to profile page", "success")
                        .then((value) => {
                            window.location = "profile.jsp";
                        });
                }
            },
            error:function (jqXHR,textStatus,errorThrown){
                // $("#login_msg").html("Something has gone Wrong..Try again").addClass("text-danger").removeClass("text-success");
                swal("Something went wrong..","","error")
            },
            processData: false,
            contentType: false,
        })
    })
})

/*logout servlet ajax*/
$("document").ready(function() {
    console.log("started");
    $("#logout").on('click', function (event) {
        event.preventDefault();
        // let f=new FormData(this);
        $.ajax({
            url:"LogoutServlet",
            // data:f,
            type:'POST',
            success:function (data,textStatus,jqXHR) {
                swal("Logged out Successfully", "we are redirecting to home page", "success")
                    .then((value) => {
                        window.location = "login.jsp";
                    });
            },
            error:function (jqXHR,textStatus,errorThrown){
                swal("Something went wrong..","","error")
            },
            processData: false,
            contentType: false,
        })
    })
})


//ajax call for add blog
$(document).ready(function (){
    $("#add-post-form").on('submit',function (event){
        event.preventDefault(); //prevent the default function of submit button
        let f=new FormData(this)  //serialize the data

        //make ajax call to ADDPOSTSERVLET
        $.ajax({
            url:"AddPostServlet",
            data:f,
            type:'POST',
            success:function (data,textStatus,jqXHR){
                swal("Posted Successfully", "", "success")
                    .then((value) => {
                        window.location = "profile.jsp";
                    });


            },
            error:function (jqXHR,textStatus,errorThrown){
                swal("Something went wrong...", "Not Posted", "error")
                    .then((value) => {
                        window.location = "profile.jsp";
                    });

            },
            processData:false,
            contentType:false,
        })
    })
})
