<%@include file="header.jsp" %>

<div class="container">
    <%        
        RoomTypeSessionBeanRemote roomBean = (RoomTypeSessionBeanRemote) ctx.lookup(RoomTypeSessionBeanRemote.class.getName());
        try {
            int rid = Integer.parseInt(request.getParameter("rid"));
            RoomType room = (RoomType) roomBean.getRoomTypeDetails(rid);
            if (room != null) {

    %>
    <h1 class="title"><%= room.getRoomTypeName()%></h1>
    <!-- RoomDetails -->
    <div id="RoomDetails" class="carousel slide" data-ride="carousel">
        <div class="carousel-inner">
            <div class="item active"><img src="images/photos/<%=r.nextInt(4) + 8%>.jpg" class="img-responsive" alt="slide"></div>
            <div class="item  height-full"><img src="images/photos/<%=r.nextInt(4) + 8%>.jpg"  class="img-responsive" alt="slide"></div>
            <div class="item  height-full"><img src="images/photos/<%=r.nextInt(4) + 8%>.jpg"  class="img-responsive" alt="slide"></div>
        </div>
        <!-- Controls -->
        <a class="left carousel-control" href="#RoomDetails" role="button" data-slide="prev"><i class="fa fa-angle-left"></i></a>
        <a class="right carousel-control" href="#RoomDetails" role="button" data-slide="next"><i class="fa fa-angle-right"></i></a>
    </div>
    <!-- RoomCarousel-->

    <div class="room-features spacer-sm">
        <div class="row">
            <div class="col-sm-12 col-md-5"> 
                <p><%= room.getRoomDescription()%></p>
            </div>
            <div class="col-sm-6 col-md-3 amenitites"> 
                <h3>Amenitites</h3>    
                <ul>
                    <%
                    %>
                    <li>One of the greatest barriers to making the sale is your prospect.</li>
                    <li>Principle to work to make more money while having more fun.</li>
                    <li>Unlucky people. Don't stubbornly.</li>
                    <li>Principle to work to make more money while having more fun.</li>
                    <li>Space in your house How to sell faster than your neighbors</li>
                </ul>


            </div>  
            <div class="col-sm-3 col-md-2">
                <div class="size-price">Size<span><%= room.getRoomSize()%> sq.ft.</span></div>
            </div>
            <div class="col-sm-3 col-md-2">
                <div class="size-price">Price<span>$<%= room.getRoomPrice()%></span></div>
            </div>
        </div>
        <% if (ub.getUserRoleID() == 0) {%>
        <a href="book-room.jsp?rid=<%= room.getRoomTypeId()%>" class='pull-right btn-xlg btn-default'>Book it</a><br /><br />
        <% } %>
    </div>

    <%
            }
        } catch (Exception e) {
        }
    %>

</div>
<%@include file="footer.jsp" %>