use CaptoolsDB
go


create view "RESP Beneficiary Age Tracking" as

select [acct#],
       [Title],
       [FirstName],
       [LastName],
	   [DOB],
	   datediff(dd,[DOB],getdate())/365 as Age,
	   [Rltn_to_Primary]+ ' of ' + [CDT_FirstNameMI]+' '+[CDT_LastName] as 'Relationship to Primary Owner' 

from [dbo].[UI3_View_Final]
	join [dbo].[Client_Details]
		on [CDT_TaxIdentifier]=[ClientID_pkey]

where [Type]='RESP' and [Rltn_to_Acct]='BENEFICIARY' 


