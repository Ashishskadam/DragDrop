<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Form_LiveEventDetails.aspx.cs" Inherits="Form_LiveEventDetails" %>

<!DOCTYPE html>
<%@ Register Src="~/User Control/DefaultLinks.ascx" TagName="DefaultLinks" TagPrefix="DL" %>
<%@ Register Src="~/User Control/Header.ascx" TagName="Header" TagPrefix="HD" %>
<%@ Register Src="~/User Control/MenuNavigation.ascx" TagName="MenuNavigation" TagPrefix="MNU" %>
<%@ Register Src="~/User Control/Footer.ascx" TagName="Footer" TagPrefix="FT" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>


<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>UK_Karate</title>
    <DL:DefaultLinks runat="server" ID="DL_1" />
    <style>
        .c-grid-profile-pic {
            width: 120px;
            text-align: center;
            padding-top: 1% !important;
            padding-bottom: 1% !important;
            vertical-align: top;
        }

        .c-btn-Renew {
            width: 15%;
            float: right;
        }

        .c-grid-col-size-300 {
            width: 350px !important;
            text-align: left;
            padding: 1% !important;
            vertical-align: middle;
        }

        .c-grid-col-size-100 {
            width: 100px !important;
            text-align: left;
            vertical-align: middle;
            padding: 1% !important;
        }

        .c-grid-col-size-150 {
            width: 150px !important;
            text-align: left;
            vertical-align: middle;
            padding: 1% !important;
        }

        .c-grid-col-size-50 {
            width: 50px !important;
            text-align: left;
            vertical-align: middle;
            padding: 1% !important;
        }

        .c-grid-col-size-200 {
            width: 200px !important;
            text-align: left;
            vertical-align: middle;
            padding: 1% !important;
        }

        .c-grid-col-size-250 {
            width: 250px !important;
            text-align: left;
            vertical-align: middle;
            padding: 1% !important;
        }

        .c-grid-col-size-275 {
            width: 275px !important;
            text-align: left;
            vertical-align: middle;
            padding: 1% !important;
        }


        .c-grid-label-3 {
            font-size: 18px;
            color: tomato;
        }

        .c-grid-label-center {
            text-align: center !important;
            vertical-align: middle !important;
        }

        .c-grid-label-left {
            text-align: left !important;
            vertical-align: middle !important;
        }

        .c-grid-label-green {
            color: green;
        }

        .c-grid-label-red {
            color: red;
        }

        .c-grid-label-1 {
            font-size: 14px;
            margin-bottom: 2px;
        }

        .c-btn-search {
            width: 15%;
            float: right;
        }

        .c-btn-widht-15 {
            width: 15%;
            float: right;
        }

        .c-btn-widht-20 {
            width: 20%;
            float: right;
        }

        .c-grid-row {
            background-color: #B2BABB !important;
            color: white;
        }

        .c-col-size-43 {
            width: 43%;
        }

        .c-col-size-60 {
            width: 60%;
        }

        .c-btn-width-55 {
            width: 55%;
        }

        @media screen and (max-width:900px) {
            .c-btn-widht-15 {
                width: 100%;
                float: right;
            }

            .c-btn-widht-20 {
                width: 50%;
                float: right;
            }

            .c-col-size-40 {
                width: 100%;
            }

            .c-col-size-43 {
                width: 100%;
            }

            .c-col-size-60 {
                width: 60%;
            }

            .c-btn-width-55 {
                width: 55%;
            }
        }
    </style>

    <link rel="stylesheet" href="plugins/datatables/dataTables.bootstrap.css" />
    <script src="plugins/datatables/jquery.dataTables.min.js"></script>
    <script src="plugins/datatables/dataTables.bootstrap.min.js"></script>


    <script type="text/javascript">


        $(document).ready(function () {
            $('#Gv_GradingEvent').dataTable({
                "bLengthChange": true,
                "paging": true,
                "sPaginationType": "full_numbers",                    //For Different Paging  Style
                // "scrollY": 400,                                     // For Scrolling
                "jQueryUI": true,                                      //Enabling JQuery UI(User InterFace)
                //"aaSorting":[[2,"desc"]]                               //To sort by created date column
                "aaSorting": [],
                //"dom": '<"top"flp>rt<"bottom"i><"clear">',
                "lengthMenu": [[5, 10, 25, 50, 100, 200, -1], [5, 10, 25, 50, 100, 200, "All"]]
                //"bFilter": false

            });

            $('div.dataTables_filter input').addClass('form-control');
            $('div.dataTables_length select').addClass('form-control');
        });

    </script>

    


    <%--dont take this style to common.--%>
    <style type="text/css">
        #Gv_GradingEvent_filter {
            /*width: 20%;*/
            float: right;
            padding-top: 7px;
            text-align: left;
            padding-left: 10px;
        }

        #Gv_GradingEvent_length {
            /* width: 13%; */
            float: left;
            padding-top: 7px;
            /* margin-left: 7%; */
        }

        #Gv_GradingEvent_paginate {
            /*width:60%;*/
            float: right;
        }
        /*#example_filter {
            visibility:hidden; //To hide the global search
            height:0;
        }*/
        .row {
            margin-right: 0px;
        }

        .odd {
            border-bottom: 2px solid #E1E5F2;
        }

        .even {
            border-bottom: 2px solid #E1E5F2;
        }


        @media screen and (max-width:900px) {
            #Gv_GradingEvent_length {
                width: 100%;
                float: left;
                padding-top: 7px;
                text-align: left;
                padding-left: 10px;
            }

            #Gv_GradingEvent_paginate {
                width: 100%;
                text-align: left;
                padding-left: 10px;
            }
        }
    </style>
</head>
<body class="hold-transition skin-purple-light sidebar-mini fixed">
    <form id="form1" runat="server">
        <div class="wrapper">
            <HD:Header runat="server" ID="HD_1" />
            <MNU:MenuNavigation runat="server" ID="MNU_1" />

            <%--content starts--%>
            <div class="content-wrapper">
                <div class="box box-solid box-info c-border-blueish c-container-box" style="margin-bottom: 0">

                    <div class="box-header c-box-blueish  with-border">
                        <asp:Label ID="Lbl_Header" runat="server" CssClass="box-title" Text="Event"></asp:Label>
                    </div>

                    <%--box body start--%>
                    <div class="box-body c-padding-top-2">
                        <asp:HiddenField ID="Hf_EventHeaderId" runat="server" Value="0" />
                        <asp:HiddenField ID="Hf_StudentId" runat="server" Value="0" />
                        <asp:HiddenField ID="Hf_StudentEnentNoteId" runat="server" Value="0" />
                        <div class="col-md-12 ">
                            <div class="col-md-6 c-col-size-60 c-label-1">
                                <asp:Label ID="Lbl_EventLabel" runat="server" CssClass="Label" Font-Size="Medium"></asp:Label>
                            </div>
                            <div class="col-md-6 no-padding c-btn-Renew c-col-size-40">
                                <asp:Button runat="server" ID="Btn_ViewEventDetail" CssClass="btn btn-primary bg-purple c-bg-blueish btn-block  btn-flat" OnClick="Btn_ViewEventDetail_Click" Text="View Event Detail" />
                            </div>
                            <div class="col-md-6 no-padding c-btn-Renew c-col-size-40">
                                <asp:Button runat="server" ID="btn_FinishGrade" CssClass="btn btn-primary bg-purple c-bg-blueish btn-block  btn-flat" OnClick="btn_FinishGrade_Click" Text="Finish Grade" />
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="table-responsive no-padding c-grid-container c-inline-space">
                                <asp:GridView runat="server" ID="Gv_Event" CssClass="table"
                                    CellSpacing="1" BorderColor="#a5969e" BorderWidth="1px"
                                    HeaderStyle-CssClass="c-grid-header" AlternatingRowStyle-CssClass="c-grid-alternaterow"
                                    DataKeyNames="StudentId"
                                    AllowPaging="true" PageSize="5"
                                    PagerStyle-CssClass="c-paging"
                                    AutoGenerateColumns="false">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Label" HeaderStyle-CssClass="c-col-size-8">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="Lbl_Label" Text='<%#Eval("Label") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="DojoCode">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="Lbl_DojoName" Text='<%#Eval("DojoName") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>


                                        <asp:TemplateField HeaderText="FullName" HeaderStyle-Width="250px">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="Lbl_FullName" Text='<%#Eval("FullName") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Grade">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="Lbl_Grade" Text='<%#Eval("Grade") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Fees">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="Lbl_Fees" Text='<%#Eval("Fees","{0:0.00}") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Fees Paid" HeaderStyle-Width="50px">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="Lbl_FeesPaid" Text='<%#Eval("FeesPaid","{0:0.00}") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Grading Fee" HeaderStyle-Width="100px">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="Lbl_GradingFeeStatusLable"  CssClass='<%#Eval("GradingFeeStatusLable") %>'></asp:Label> &nbsp
                                                <asp:Label runat="server" ID="Lbl_GradingFee" Text='<%#Eval("GradingFeeStatus") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Membership Fee">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="Lbl_MembershipFee" Text='<%#Eval("MembershipFee") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="Btn_ViewPayment" runat="server" CssClass="fa fa-eye inline-icon-size-large"
                                                    data-toggle="tooltip" title="View Payment" OnClick="Btn_ViewPayment_Click"
                                                    CommandArgument='<%#Eval("StudentId") %>'></asp:LinkButton>
                                                <br />
                                                <asp:LinkButton ID="Btn_Note" runat="server" CssClass="fa fa-pencil-square-o inline-icon-size-large"
                                                    data-toggle="tooltip" title="Note" OnClick="Btn_Note_Click"
                                                      CommandArgument='<%#Eval("StudentId") %>'></asp:LinkButton>
                                                <br />
                                                <asp:Button ID="Btn_Move" runat="server" Text="Move" CommandArgument='<%#Eval("StudentId") %>' CssClass="btn bg-purple c-bg-blueish btn-flat c-btn-height " OnClick="Btn_Move_Click" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>

                            </div>
                        </div>

                        <div class="modal fade" id="Modal_Note" role="dialog">
                            <div class="modal-dialog modal-lg">
                                <div class="modal-content">
                                    <div class="modal-header box-header c-box-blueish c-modal-head">
                                        <button type="button" class="close c-close" data-dismiss="modal">&times;</button>
                                        <h4 class="modal-title">Note</h4>
                                    </div>
                                    <div class="modal-body c-modal-height">
                                        <div class="col-md-12 c-inline-space">
                                            <div class="col-md-2 c-col-size-14 c-label-1">
                                                <asp:Label ID="Label37" CssClass="Label" runat="server" Text="Note"></asp:Label>
                                            </div>
                                            <div class="col-md-10 no-padding c-col-size-86">
                                                <asp:TextBox runat="server" ID="Tb_Note" CssClass="form-control" placeholder="Note" TextMode="MultiLine"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-md-12 col-md-offset-4 c-button-box-intermidiate">
                                            <div class="col-md-10 no-padding">
                                                <div class="col-md-4 c-btn-widht-25">
                                                    <asp:Button ID="btn_SaveNote" runat="server" Text="Save" OnClick="btn_SaveNote_Click"
                                                        CssClass="btn bg-purple c-bg-blueish btn-block  btn-flat c-with-shadow" />
                                                </div>
                                            </div>
                                        </div>

                                    </div>

                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal fade" id="Modal_Payment" role="dialog">
                            <div class="modal-dialog modal-lg">
                                <div class="modal-content">
                                    <div class="modal-header box-header c-box-blueish c-modal-head">
                                        <button type="button" class="close c-close" data-dismiss="modal">&times;</button>
                                        <h4 class="modal-title">View Payments</h4>
                                    </div>
                                    <div class="modal-body c-modal-height">
                                        <div class="col-md-12 c-inline-space">
                                            <asp:Label ID="Label1" CssClass="Label" runat="server" Text="Term and Membership Fees" Font-Size="Large"></asp:Label>
                                        </div>
                                        <div class="col-md-12 c-inline-space">
                                            <div class="col-md-6">
                                                <asp:Label ID="Label3" CssClass="Label" runat="server" Text="Fees Paid" Font-Bold="true"></asp:Label><br />
                                                <asp:TextBox ID="Tb_FeePaid" runat="server" CssClass="form-control"></asp:TextBox>
                                            </div>
                                            <div class="col-md-6">
                                                <asp:Label ID="Label4" CssClass="Label" runat="server" Text="Date" Font-Bold="true"></asp:Label><br />
                                                <asp:Label ID="Lbl_Date" CssClass="Label" runat="server"></asp:Label><br />
                                            </div>
                                        </div>
                                        <div class="col-md-12 c-inline-space">
                                            <asp:Label ID="Label2" CssClass="Label" runat="server" Text="Grading Fees" Font-Size="Large"></asp:Label>
                                        </div>
                                        <div class="col-md-12 c-inline-space">
                                            <div class="col-md-6">
                                                <asp:Label ID="Label6" CssClass="Label" runat="server" Text="Fees Paid" Font-Bold="true"></asp:Label><br />
                                                <asp:TextBox ID="Tb_GradingFee" runat="server" CssClass="form-control"></asp:TextBox>
                                            </div>
                                            <div class="col-md-6">
                                                <asp:Label ID="Label7" CssClass="Label" runat="server" Text="Date" Font-Bold="true"></asp:Label><br />
                                                <asp:Label ID="Lbl_GradingDate" CssClass="Label" runat="server"></asp:Label><br />
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <FT:Footer runat="server" ID="FT_1" />
        </div>
    </form>
</body>
</html>
