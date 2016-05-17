# Script to identify users who are not required to have a strong password
# Users identifed in this report may NOT actually have a weak password, but thier setting allow them to have a week password
# This report includes users who are locked
# Note that when a user has been forced to use a strong password they must change thier password before this report is up to date

Get-MsolUser |select UserPrincipalName, strongpasswordrequired |sort strongpasswordrequired