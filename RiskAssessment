select 
[CDT_LastName] + '_' + [CDT_FirstNameMI] as ClientID, convert(varchar,[CDT_DateOfBirth],101) as DOB,
[PVL_ClientAccountNumber] as Account, [ADT_AccountTitle] as AcctTitle,
cln.cdt_family as Family, 
[ADT_AccountCode] as Broker,
acc.adt_accountType, [PVL_Value] as Value, 
rtrim(ltrim(cln.cdt_PrimaryCity)) as City,
rtrim(ltrim(cln.cdt_PrimaryState)) as Province,
left(rtrim(ltrim(cln.cdt_primaryPostal)),3) + space(1) + right(rtrim(ltrim(cln.cdt_primaryPostal)),3) as CityProvPostal,
CONVERT(VARCHAR(10),[PVL_Date],101) as Portfolio_Value_Date,
[ADT_BaseCurrency] as BaseCurrency,

(select [SPH_Close] from [Adbo].[SecList_PriceHistory]
where [SPH_Date] = [PVL_Date] and [SPH_Symbol] = 'US$>$') as FX,

case 
when [ADT_BaseCurrency] = 'US$' then
(select [SPH_Close] from [dbo].[SecList_PriceHistory]
where [SPH_Date] = [PVL_Date] and [SPH_Symbol] = 'US$>$') * [PVL_Value]
else [PVL_Value]
end as FXAdjValue,
adt_UserDefined5 as CaptoolsType,

case
when [PVL_ClientAccountNumber] in (account names are removed for privacy)  then 'Institution' 

when adt_UserDefined5 = 'Individual' then 'Individuals'
when adt_UserDefined5 = 'Joint' then 'Individuals'
when adt_UserDefined5 = 'Corporation' then 'Corporation' 
when adt_UserDefined5 = 'Estate' then 'Estate'  
when adt_UserDefined5 = 'NFP' then 'Institution'
when adt_UserDefined5 = 'Trust' then 'Trust'
else 'Individuals' end as RiskAssess_Type,
datediff(year,[CDT_DateOfBirth],[PVL_Date]) as Age_asOf_ValueDate,
[CDT_UserDef9] as CountryOfResidence

from account_details as acc inner join client_details as cln 
on acc.adt_TaxIdentifier = cln.cdt_TaxIdentifier inner join [dbo].[Portfolio_Valuations]
on adt_clientAccountNumber = [PVL_ClientAccountNumber]
where cln.cdt_repid <> 'CLOSED' AND acc.adt_accountinactive <> 'TRUE' 
and [PVL_Date] = '2016-03-31'  /*** CHANGE DATE HERE ***/

order by adt_UserDefined5
