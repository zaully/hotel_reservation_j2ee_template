<%@include file="header.jsp" %>
<!-- banner -->
<div class="banner">    	   
    <img src="images/photos/banner.jpg"  class="img-responsive" alt="slide">
    <div class="welcome-message">
        <div class="wrap-info">
            <div class="information">
                <h1  class="animated fadeInDown">Best hotel in Toronto</h1>
                <p class="animated fadeInUp">Most luxurious hotel of Canada with the royal treatments and excellent customer service.</p>                
            </div>
            <a href="#information" class="arrow-nav scroll wowload fadeInDownBig"><i class="fa fa-angle-down"></i></a>
        </div>
    </div>
</div>
<!-- banner-->


<!-- login-information -->
<div id="information" class="spacer reserve-info ">
    <div class="container">
        <div class="row">
            <div class="col-sm-7 col-md-8">
                <div class="embed-responsive embed-responsive-16by9 wowload fadeInLeft"><iframe  class="embed-responsive-item" src="//player.vimeo.com/video/55057393?title=0" width="100%" height="400" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe></div>
            </div>
            <div class="col-sm-5 col-md-4">
                <ul class="nav nav-pills">
                    <li role="presentation" class="active"><a href="#index_register_tab" data-toggle="pill">Register</a></li>
                    <li role="presentation"><a href="#index_login_tab" data-toggle="pill">Login</a></li>
                </ul>
                <div id="index-tab-content" class="tab-content">
                    <br />
                    <div class="tab-pane active" id="index_register_tab">
                        <form role="form" class="wowload fadeInRight">
                            <div class="form-group">
                                <input type="email" class="form-control"  placeholder="Email (will be your username)">
                            </div>
                            <div class="form-group">
                                <input type="text" class="form-control"  placeholder="Name">
                            </div>
                            <div class="form-group">
                                <input type="Phone" class="form-control"  placeholder="Phone">
                            </div>
                            <div class="form-group">
                                <input type="password" class="form-control"  placeholder="Password">
                            </div>
                            <div class="form-group">
                                <input type="password" class="form-control"  placeholder="Confirm your password">
                            </div>
                            <div class="form-group">
                                <textarea class="form-control" placeholder="Your preference" rows="3"></textarea>
                            </div>
                            <button class="btn btn-default">Submit</button>
                        </form>
                    </div>
                    <div class="tab-pane" id="index_login_tab">
                        <form class="wowload fadeInRight">
                            <div class="form-group">
                                <input type="email" class="form-control" placeholder="email" />
                            </div>
                            <div class="form-group">
                                <input type="password" class="form-control" placeholder="password" />
                            </div>
                            <button class="btn btn-default">Login</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>  
    </div>
</div>
<!-- login-information -->
<%@include file="footer.jsp" %>