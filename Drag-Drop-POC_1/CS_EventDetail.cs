using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Drag_Drop_POC
{
    public class CS_EventDetail
    {
        public int Index { get; set; }
        public int SrNo { get; set; }
        public int StudentId { get; set; }
        public int EventHeaderId { get; set; }
        public int EventDetailId { get; set; }
        public string Label { get; set; }
        public string FullName { get; set; }
        public double Fees { get; set; }
        public double FeesPaid { get; set; }
        public string MembershipFee { get; set; }
        public string DojoName { get; set; }
        public string Grade { get; set; }
        public int EventKyuId { get; set; }
        public double GradingFee { get; set; }
        public string GradingFeeStatus { get; set; }
        public string EventDate { get; set; }
        public int IsFullyPaid { get; set; }
    }
}