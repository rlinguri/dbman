#
#       ----------------------
#               DBMan
# 		----------------------
#		Database Administrator
#
#         File: html.pl
#  Description: This file contains all the HTML that the program generates.
#       Author: Alex Krohn
#          Web: http://www.gossamer-threads.com/
#      Version: 2.05
# CVS Revision: $Id: html.pl,v 1.3 2000/07/08 18:14:40 alex Exp $
#
# COPYRIGHT NOTICE:
#
# Copyright 1997 Gossamer Threads Inc.  All Rights Reserved.
#
# This program is being distributed as shareware.  It may be used and
# modified free of charge for personal, academic, government or non-profit
# use, so long as this copyright notice and the header above remain intact.
# Any commercial use should be registered.  Please also send me an email,
# and let me know where you are using this script. By using this program 
# you agree to indemnify Gossamer Threads Inc. from any liability.
#
# Selling the code for this program without prior written consent is
# expressly forbidden.  Obtain permission before redistributing this
# program over the Internet or in any other medium.  In all cases
# copyright and header must remain intact.
#
# Please check the README file for full details on registration.
# =====================================================================

##########################################################
##						HTML Globals					##
##########################################################
# Put any globals you like in here for your html pages.
$html_title  = 'Database Manager Demo';

##########################################################
##						Record Layout					##
##########################################################

sub html_record_form {
# --------------------------------------------------------
# The form fields that will be displayed each time a record is
# edited (including searching). You don't want to put the 
# <FORM> and </FORM tags, merely the <INPUT> tags for each field.
# The values to be displayed are in %rec and should be incorporated
# into your form. You can use &build_select_field, &build_checkbox_field 
# and &build_radio_field to generate the respective input boxes. Text and
# Textarea inputs can be inserted as is. If you turn on form auto
# generation, the program will build the forms for you (all though they may
# not be as nice). See the README for more info.

	my (%rec) = @_;
	($db_auto_generate and print &build_html_record_form(%rec) and return);
	
	my $font = 'Font face="Verdana, Arial, Helvetica" Size=2 Color=#003399';

	print qq|
	<TABLE WIDTH="450" CELLPADDING=0 CELLSPACING=0 BORDER=1 BGCOLOR="#FFFFCC">
        <TR><TD ALIGN="Right" VALIGN="TOP" WIDTH="150"><$font>ID:</FONT></TD>
                <TD VALIGN="TOP" WIDTH="475">&nbsp;<INPUT TYPE="TEXT" NAME="ID" VALUE="$rec{'ID'}" SIZE="3" MAXLENGTH="3"></TD></TR>
        <TR><TD ALIGN="Right" VALIGN="TOP"><$font>Title:</FONT></TD>
                <TD VALIGN="TOP">&nbsp;<INPUT TYPE="TEXT" NAME="Title" VALUE="$rec{'Title'}" SIZE="40" MAXLENGTH="255"></TD></TR>
        <TR><TD ALIGN="Right" VALIGN="TOP"><$font>URL: </FONT></TD>
                <TD VALIGN="TOP">&nbsp;<INPUT TYPE="TEXT" NAME="URL" VALUE="$rec{'URL'}" SIZE="40" MAXLENGTH="255"></TD></TR>
        <TR><TD ALIGN="Right" VALIGN="TOP"><$font>Type: </FONT></TD>
                <TD VALIGN="TOP">&nbsp;|; print &build_select_field ("Type", "$rec{'Type'}"); print qq|</TD></TR>
        <TR><TD ALIGN="Right" VALIGN="TOP"><$font>Date:</FONT></TD>
                <TD VALIGN="TOP">&nbsp;<INPUT TYPE="TEXT" NAME="Date" VALUE="$rec{'Date'}" SIZE="12" MAXLENGTH="12"></TD></TR>
        <TR><TD ALIGN="Right" VALIGN="TOP"><$font>Category:</FONT></TD>
                <TD VALIGN="TOP">&nbsp;|; print &build_select_field ("Category", "$rec{'Category'}"); print qq|</TD></TR>
        <TR><TD ALIGN="Right" VALIGN="TOP"><$font>Description:</FONT></TD>
                <TD VALIGN="TOP">&nbsp;<TEXTAREA NAME="Description" ROWS="4" COLS="40" WRAP="VIRTUAL" MAXLENGTH="255">$rec{'Description'}</TEXTAREA></TD></TR>
        <TR><TD ALIGN="Right" VALIGN="TOP"><$font>Validated:</FONT></TD>
                <TD VALIGN="TOP">&nbsp;|; print &build_radio_field ("Validated", "$rec{'Validated'}"); print qq|</TD></TR>
        <TR><TD ALIGN="Right" VALIGN="TOP"><$font>Popular:</FONT></TD>
                <TD VALIGN="TOP">&nbsp;|; print &build_checkbox_field ("Popular", "$rec{'Popular'}"); print qq|</TD></TR>
	</TABLE>
	|;
}

sub html_record {
# --------------------------------------------------------
# How a record will be displayed. This is used primarily in 
# returning search results and how it is formatted. The record to
# be displayed will be in the %rec hash.

	my (%rec) = @_;		# Load any defaults to put in the VALUE field.
	($db_auto_generate and print &build_html_record(%rec) and return);
	
	my $font_color = 'Font face="Verdana, Arial, Helvetica" Size=2 Color=#003399';
	my $font       = 'Font face="Verdana, Arial, Helvetica" Size=2';
	
	print qq|
	<TABLE WIDTH="475" CELLPADDING=0 CELLSPACING=0 BORDER=1 BGCOLOR="#FFFFCC">
	<TR><TD ALIGN="Right" VALIGN="TOP" WIDTH="20%"><$font_color>ID:</FONT></TD>
		<TD WIDTH="80%">&nbsp;<$font>$rec{'ID'}</Font></TD></TR>
	<TR><TD ALIGN="Right" VALIGN="TOP"><$font_color>Title:</FONT></TD>
		<TD>&nbsp;<$font>$rec{'Title'}</Font></TD></TR>
	<TR><TD ALIGN="Right" VALIGN="TOP"><$font_color>URL: </FONT></TD>
		<TD>&nbsp;<$font><A HREF="$rec{'URL'}">$rec{'URL'}</A></Font></TD></TR>
	<TR><TD ALIGN="Right" VALIGN="TOP"><$font_color>Type: </FONT></TD>
		<TD>&nbsp;<$font>$rec{'Type'}</Font></TD></TR>
	<TR><TD ALIGN="Right" VALIGN="TOP"><$font_color>Date:</FONT></TD>
		<TD>&nbsp;<$font>$rec{'Date'}</Font></TD></TR>
	<TR><TD ALIGN="Right" VALIGN="TOP"><$font_color>Category:</FONT></TD>
		<TD>&nbsp;<$font>$rec{'Category'}</Font></TD></TR>		
	<TR><TD ALIGN="Right" VALIGN="TOP"><$font_color>Description:</FONT></TD>
		<TD>&nbsp;<$font>$rec{'Description'}</Font></TD></TR>				
	<TR><TD ALIGN="Right" VALIGN="TOP"><$font_color>Validated:</FONT></TD>
		<TD>&nbsp;<$font>$rec{'Validated'}</Font></TD></TR>				
	<TR><TD ALIGN="Right" VALIGN="TOP"><$font_color>Popular:</FONT></TD>
		<TD>&nbsp;<$font>$rec{'Popular'}</Font></TD></TR>				
	</TABLE>
	|;
}

##########################################################
##						Home Page  						##
##########################################################

sub html_home {
# --------------------------------------------------------
# The database manager home page.

	&html_print_headers;
	print  qq|
<html>
<head>
	<title>$html_title: Main Menu.</title>
</head>

<body bgcolor="#DDDDDD">
	<center>
		<table border=1 bgcolor="#FFFFFF" cellpadding=5 cellspacing=3 width=500 align=center valign=top>
			<tr><td colspan=2 bgcolor="navy">
					<FONT FACE="MS Sans Serif, arial,helvetica" size=1 COLOR="#FFFFFF">
                    <b>$html_title: Main Menu</b>
			</td></tr>
			<tr><td>
					<p><center><$font_title><b>
						Main Menu
					</b></font></center><br>
					<font face="verdana,arial,helvetica" size="1"><b>
					Permissions: |;
print " View " if ($per_view);
print " Add " if ($per_add);
print " Delete " if ($per_del);
print " Modify " if ($per_mod);
print " Admin " if ($per_admin);
print " None " if (!($per_view || $per_add || $per_del || per_mod));
print qq|</b></font>
					<P><$font>
						This database has been set up so any user can view any other users information, but you can
						only modify and delete your own records. If you have admin access, you can of course do anything
						you like.<br><br>
						<em>Enjoy!</em> and let me <a href="mailto:alex\@gossamer-threads.com">know</a> if you have any comments!
					</font>
					
					</p>
					|; &html_footer; print qq|
			</td></tr>
		</table>
	</center>	   
</body>
</html>
|;
}

sub html_footer {
# --------------------------------------------------------
# Print the menu and the footer and logo. It would be nice if you left
# the logo in. ;)
#
# We only print options that the user have permissions for.
#

	my $font       = 'Font face="Verdana, Arial, Helvetica" Size=2';

	print qq!<P align=center><$font>!;
	print qq!| <A HREF="$db_script_link_url">Home</A> !;
	print qq!| <A HREF="$db_script_link_url&add_form=1">Add</A> ! 				    if ($per_add);
	print qq!| <A HREF="$db_script_link_url&view_search=1">View</A> ! 				if ($per_view);
	print qq!| <A HREF="$db_script_link_url&delete_search=1">Delete</A> ! 			if ($per_del);
	print qq!| <A HREF="$db_script_link_url&modify_search=1">Modify</A> ! 			if ($per_mod);
	print qq!| <A HREF="$db_script_link_url&view_records=1&$db_key=*">List All</A> ! if ($per_view);
	print qq!| <A HREF="$db_script_link_url&admin_display=1">Admin</A> ! 			if ($per_admin);
	print qq!| <A HREF="$db_script_link_url&logoff=1">Log Off</A> |!;
	print qq!</font></p>!;

# Print the Footer -- note: a link (doesn't have to be the graphic) is required unless you purchase
# a license. See: http://gossamer-threads.com/scripts/register/ for more info.
	print qq!	
		<table border=0 width=100%>
			<tr><td align=left><$font>Database Powered by <A HREF="http://www.gossamer-threads.com">Gossamer Threads Inc.</A></font></td>
				<td align=right><a href="http://www.gossamer-threads.com/scripts/dbman/"><img src="http://www.gossamer-threads.com/images/powered.gif" border=0 width=100 height=31 alt="Database Powered by Gossamer Threads Inc."></a></td></tr>
		</table>
	!;
}	

sub html_search_options {
# --------------------------------------------------------
# Search options to be displayed at the bottom of search forms.
#
	print qq~
	<P>
	<STRONG>Search Options:</STRONG> <br>
	<INPUT TYPE="CHECKBOX" NAME="ma"> Match Any 
	<INPUT TYPE="CHECKBOX" NAME="cs"> Match Case 
	<INPUT TYPE="CHECKBOX" NAME="ww"> Whole Words 
	<INPUT TYPE="CHECKBOX" NAME="re"> Reg. Expression<BR>
	<INPUT TYPE="TEXT" NAME="keyword" SIZE=15 MAXLENGTH=255> Keyword Search <FONT SIZE=-1> (will match against all fields)</FONT><BR>
	<INPUT TYPE="TEXT" NAME="mh" VALUE="$db_max_hits" SIZE=3 MAXLENGTH=3> Max. Returned Hits<BR>
	Sort By:
	<SELECT NAME="sb">
		<OPTION>---
	~; for (my $i =0; $i <= $#db_cols; $i++) { print qq~<OPTION VALUE="$i">$db_cols[$i]</OPTION>\n~ if ($db_form_len{$db_cols[$i]} >= 0); } print qq~
	</SELECT>
	Sort Order:
	<SELECT NAME="so">
		<OPTION VALUE="ascend">Ascending
		<OPTION VALUE="descend">Descending
	</SELECT><br><br>
	<strong>Search Tips:</strong><br>
	&nbsp;&nbsp;&nbsp;&nbsp;- use '*' to match everything in a field)<BR>
	&nbsp;&nbsp;&nbsp;&nbsp;- put a '&gt;' or '&lt;' at the beginning to to do range searches.<BR>	
	~;
}

##########################################################
##						Adding  						##
##########################################################

sub html_add_form {
# --------------------------------------------------------
# The add form page where the user fills out all the details
# on the new record he would like to add. You should use 
# &html_record_form to print out the form as it makes
# updating much easier. Feel free to edit &get_defaults
# to change the default values.

	&html_print_headers;
	print qq|
<html>
<head>
	<title>$html_title: Add a New Record.</title>
</head>

<body bgcolor="#DDDDDD">
	<form action="$db_script_url" method="POST">
		<input type=hidden name="db" value="$db_setup">
		<input type=hidden name="uid" value="$db_uid">	
	<center>
		<table border=1 bgcolor="#FFFFFF" cellpadding=5 cellspacing=3 width=500 align=center valign=top>
			<tr><td colspan=2 bgcolor="navy">
					<FONT FACE="MS Sans Serif, arial,helvetica" size=1 COLOR="#FFFFFF">
                    <b>$html_title: Add a New Record</b>
			</td></tr>
			<tr><td>
					<p><center><$font_title><b>
						Add a New Record
					</b></font></center><br>
					<$font>
						|; &html_record_form (&get_defaults); print qq|
					</font></p>
					<p><center> <INPUT TYPE="SUBMIT" NAME="add_record" VALUE="Add Record"> <INPUT TYPE="RESET" VALUE="Reset Form"></center></p>
					|; &html_footer; print qq|
			</td></tr>
		</table>
	</center>	   
	</form>
</body>
</html>	
|;
}

sub html_add_success {
# --------------------------------------------------------
# The page that is returned upon a successful addition to
# the database. You should use &get_record and &html_record
# to verify that the record was inserted properly and to make
# updating easier.

	&html_print_headers;
	print qq|
<html>
<head>
	<title>$html_title: Record Added.</title>
</head>

<body bgcolor="#DDDDDD">
	<center>
		<table border=1 bgcolor="#FFFFFF" cellpadding=5 cellspacing=3 width=500 align=center valign=top>
			<tr><td colspan=2 bgcolor="navy">
					<FONT FACE="MS Sans Serif, arial,helvetica" size=1 COLOR="#FFFFFF">
                    <b>$html_title: Record Added</b>
			</td></tr>
			<tr><td>
					<p><center><$font_title><b>
						Record Added
					</b></font></center><br>
					<$font>
						<P><Font face="Verdana, Arial, Helvetica" Size=2>The following record was successfully added to the database:</FONT>
						|; &html_record(&get_record($in{$db_key})); print qq|	
					</font></p>
					|; &html_footer; print qq|
			</td></tr>
		</table>
	</center>	   
</body>
</html>		
|;
}

sub html_add_failure {
# --------------------------------------------------------
# The page that is returned if the addition failed. An error message 
# is passed in explaining what happened in $message and the form is
# reprinted out saving the input (by passing in %in to html_record_form).

	my ($message) = $_[0];
	
	&html_print_headers;
	print qq|
<html>
<head>
	<title>$html_title: Error! Unable to Add Record.</title>
</head>

<body bgcolor="#DDDDDD">
	<form action="$db_script_url" method="POST">
		<input type=hidden name="db" value="$db_setup">
		<input type=hidden name="uid" value="$db_uid">	
	<center>
		<table border=1 bgcolor="#FFFFFF" cellpadding=5 cellspacing=3 width=500 align=center valign=top>
			<tr><td colspan=2 bgcolor="navy">
					<FONT FACE="MS Sans Serif, arial,helvetica" size=1 COLOR="#FFFFFF">
                    <b>$html_title: Error: Unable to Add Record</b>
			</td></tr>
			<tr><td>
					<p><center><$font_title><b>
						Error: <font color=red>Unable to Add Record</font>
					</b></font></center><br>
					<$font>
						There were problems with the following fields: <FONT COLOR="red"><B>$message</B></FONT>
						<P>Please fix any errors and submit the record again.</p></font>
						|; &html_record_form (%in); print qq|
					</font></p>
					<p><center> <INPUT TYPE="SUBMIT" NAME="add_record" VALUE="Add Record"> <INPUT TYPE="RESET" VALUE="Reset Form"></center></p>
					|; &html_footer; print qq|
			</td></tr>
		</table>
	</center>	   
	</form>
</body>
</html>	
|;
}

##########################################################
##						Viewing							##
##########################################################

sub html_view_search {
# --------------------------------------------------------
# This page is displayed when a user requests to search the 
# database for viewing. 
# Note: all searches must use GET method.
#
	&html_print_headers;
	print qq|
<html>
<head>
	<title>$html_title: Search the Database.</title>
</head>

<body bgcolor="#DDDDDD">
	<form action="$db_script_url" method="GET">
		<input type=hidden name="db" value="$db_setup">
		<input type=hidden name="uid" value="$db_uid">	
	<center>
		<table border=1 bgcolor="#FFFFFF" cellpadding=5 cellspacing=3 width=500 align=center valign=top>
			<tr><td colspan=2 bgcolor="navy">
					<FONT FACE="MS Sans Serif, arial,helvetica" size=1 COLOR="#FFFFFF">
                    <b>$html_title: Search the Database</b>
			</td></tr>
			<tr><td>
					<p><center><$font_title><b>
						Search the Database
					</b></font></center><br>
					<$font>
						|;  &html_record_form(); print qq|
						|; &html_search_options; print qq|
					</font></p>
					<p><center> <INPUT TYPE="SUBMIT" NAME="view_records" VALUE="View Records"> <INPUT TYPE="RESET" VALUE="Reset Form"></center></p>
					|; &html_footer; print qq|
			</td></tr>
		</table>
	</center>	   
	</form>
</body>
</html>	
|;
}

sub html_view_success {
# --------------------------------------------------------
# This page displays the results of a successful search. 
# You can use the following variables when displaying your 
# results:
#
#        $numhits - the number of hits in this batch of results.
#        $maxhits - the max number of hits displayed.
#        $db_total_hits - the total number of hits.
#        $db_next_hits  - html for displaying the next set of results.
#       
	
	my (@hits) = @_;
	my ($numhits) = ($#hits+1) / ($#db_cols+1);
	my ($maxhits); $in{'mh'} ? ($maxhits = $in{'mh'}) : ($maxhits = $db_max_hits);	
	
	&html_print_headers;	
	print qq|
<html>
<head>
	<title>$html_title: Search Results.</title>
</head>

<body bgcolor="#DDDDDD">
	<blockquote>
	<table border=1 bgcolor="#FFFFFF" cellpadding=5 cellspacing=3 width=500 valign=top>
		<tr><td colspan=2 bgcolor="navy"><FONT FACE="MS Sans Serif, arial,helvetica" size=1 COLOR="#FFFFFF">
                   <b>$html_title: Search Results</b>
		</font></td></tr>
	</table>
	<p><$font>
		Your search returned <b>$db_total_hits</b> matches.</font>
|;
	if ($db_next_hits) {
		print "<br><$font>Pages: $db_next_hits</font>";
	}
	
# Go through each hit and convert the array to hash and send to 
# html_record for printing.
	for (0 .. $numhits - 1) {
		print "<P>";
		&html_record (&array_to_hash($_, @hits));
	}
	if ($db_next_hits) {
		print "<br><$font>Pages: $db_next_hits</font>";
	}
	
	print qq|
		<p>
		<table border=0 bgcolor="#DDDDDD" cellpadding=5 cellspacing=3 width=500 valign=top>
			<tr><td>|; &html_footer; print qq|</td></tr>
		</table>
	</blockquote>
</body>
</html>
|;
}

sub html_view_failure {
# --------------------------------------------------------
# The search for viewing failed. The reason is stored in $message
# and a new search form is printed out.

	my ($message) = $_[0];
	
	&html_print_headers;
	print qq|
<html>
<head>
	<title>$html_title: Search Failed.</title>
</head>

<body bgcolor="#DDDDDD">
	<form action="$db_script_url" method="GET">
		<input type=hidden name="db" value="$db_setup">
		<input type=hidden name="uid" value="$db_uid">	
	<center>
		<table border=1 bgcolor="#FFFFFF" cellpadding=5 cellspacing=3 width=500 align=center valign=top>
			<tr><td colspan=2 bgcolor="navy">
					<FONT FACE="MS Sans Serif, arial,helvetica" size=1 COLOR="#FFFFFF">
                    <b>$html_title: Search Failed</b>
			</td></tr>
			<tr><td>
					<p><center><$font_title><b>
						Search Failed
					</b></font></center><br>
					<$font>
						<P>There were problems with the search. Reason: <FONT COLOR="red"><B>$message</B></FONT>
						<BR>Please fix any errors and submit the record again.</p>
						|;  &html_record_form(%in); print qq|
						|; &html_search_options; print qq|</p>
					</font></p>
					<p><center> <INPUT TYPE="SUBMIT" NAME="view_records" VALUE="View Records"> <INPUT TYPE="RESET" VALUE="Reset Form"></center></p>
					|; &html_footer; print qq|
			</td></tr>
		</table>
	</center>	   
	</form>
</body>
</html>
|;
}

##########################################################
##						Deleting						##
##########################################################

sub html_delete_search {
# --------------------------------------------------------
# The page is displayed when a user wants to delete records. First
# the user has to search the database to pick which records to delete.
# That's handled by this form.

	&html_print_headers;
	print qq|
<html>
<head>
	<title>$html_title: Search the Database for Deletion.</title>
</head>

<body bgcolor="#DDDDDD">
	<form action="$db_script_url" method="GET">
		<input type=hidden name="db" value="$db_setup">
		<input type=hidden name="uid" value="$db_uid">	
	<center>
		<table border=1 bgcolor="#FFFFFF" cellpadding=5 cellspacing=3 width=500 align=center valign=top>
			<tr><td colspan=2 bgcolor="navy">
					<FONT FACE="MS Sans Serif, arial,helvetica" size=1 COLOR="#FFFFFF">
                    <b>$html_title: Search the Database for Deletion</b>
			</td></tr>
			<tr><td>
					<p><center><$font_title><b>
						Search the Database for Deletion
					</b></font></center><br>
					<$font>
						<P>Search the database for the records you wish to delete or 
						   <A HREF="$db_script_link_url&delete_form=1&$db_key=*">list all</a>:</p>
						|;  &html_record_form(); print qq|
						|; &html_search_options; print qq|</p>
					</font></p>
					<p><center> <INPUT TYPE="SUBMIT" NAME="delete_form" VALUE="Search"> <INPUT TYPE="RESET" VALUE="Reset Form"></center></p>
					|; &html_footer; print qq|
			</td></tr>
		</table>
	</center>	   
	</form>
</body>
</html>	
|;
}

sub html_delete_form {
# --------------------------------------------------------
# The user has searched the database for deletion and must now
# pick which records to delete from the records returned. This page
# should produce a checkbox with name=ID value=delete for each record.
# We have to do a little work to convert the array @hits that contains
# the search results to a hash for printing.

	my ($status, @hits) = &query("mod");	
	my ($numhits) = ($#hits+1) / ($#db_cols+1);
	my ($maxhits); $in{'mh'} ? ($maxhits = $in{'mh'}) : ($maxhits = $db_max_hits);
	my (%tmp);
	
	&html_print_headers;
	print qq|
<html>
<head>
	<title>$html_title: Delete Record(s).</title>
</head>

<body bgcolor="#DDDDDD">
	<form action="$db_script_url" METHOD="POST">
		<input type=hidden name="db" value="$db_setup">
		<input type=hidden name="uid" value="$db_uid">
	
	<blockquote>
	<table border=1 bgcolor="#FFFFFF" cellpadding=5 cellspacing=3 width=500 valign=top>
		<tr><td colspan=2 bgcolor="navy">
				<FONT FACE="MS Sans Serif, arial,helvetica" size=1 COLOR="#FFFFFF">
                   <b>$html_title: Delete Record(s)</b>
		</td></tr>
	</table>
	<p><$font>
		Check which records you wish to delete and then press "Delete Records":<br>
		Your search returned <b>$db_total_hits</b> matches.</font>
|;
	if ($db_next_hits) {
		print "<br><$font>Pages: $db_next_hits</font>";
	}
# Go through each hit and convert the array to hash and send to 
# html_record for printing. Also add a checkbox with name=key and value=delete.

	if ($status ne "ok") {	# There was an error searching!
		print qq|<P><FONT COLOR="RED" SIZE=4>Error: $status</FONT></P>|;
	}
	else {
		print "<P>";
		for (0 .. $numhits - 1) {
			%tmp = &array_to_hash($_, @hits);
			print qq|<TABLE BORDER=0><TR><TD><INPUT TYPE=CHECKBOX NAME="$tmp{$db_key}" VALUE="delete"></TD><TD>|;
			&html_record (%tmp);
			print qq|</TD></TR></TABLE>\n|;			
		}
		if ($db_next_hits) {
			print "<br><$font>Pages: $db_next_hits</font>";
		}
	}
	print qq|
		<p>
		<table border=0 bgcolor="#DDDDDD" cellpadding=5 cellspacing=3 width=500 valign=top>
			<tr><td>
				<p><center><INPUT TYPE="SUBMIT" name="delete_records" VALUE="Delete Checked Record(s)"> <INPUT TYPE="RESET" VALUE="Reset Form"></center></p>
				|; &html_footer; print qq|
			</td></tr>
		</table>
	</blockquote>
</body>
</html>
|;
}

sub html_delete_success {
# --------------------------------------------------------
# This page let's the user know that the records were successfully
# deleted.

	my $message = shift;

	&html_print_headers;
	print qq|
<html>
<head>
	<title>$html_title: Record(s) Deleted.</title>
</head>

<body bgcolor="#DDDDDD">
	<center>
		<table border=1 bgcolor="#FFFFFF" cellpadding=5 cellspacing=3 width=500 align=center valign=top>
			<tr><td colspan=2 bgcolor="navy">
					<FONT FACE="MS Sans Serif, arial,helvetica" size=1 COLOR="#FFFFFF">
                    <b>$html_title: Record(s) Deleted.</b>
			</td></tr>
			<tr><td>
					<p><center><$font_title><b>
						Record(s) Deleted
					</b></font></center><br>
					<$font>
						The following records were deleted from the database: '$message'.
					</font></p>
					|; &html_footer; print qq|
			</td></tr>
		</table>
	</center>	   
</body>
</html>	
|;
}

sub html_delete_failure {
# --------------------------------------------------------
# This page let's the user know that some/all of the records were
# not deleted (because they were not found in the database). 
# $errstr contains a list of records not deleted.

	my ($errstr) = $_[0];
	
	&html_print_headers;
	print qq|
<html>
<head>
	<title>$html_title: Error: Record(s) Not Deleted.</title>
</head>

<body bgcolor="#DDDDDD">
	<center>
		<table border=1 bgcolor="#FFFFFF" cellpadding=5 cellspacing=3 width=500 align=center valign=top>
			<tr><td colspan=2 bgcolor="navy">
					<FONT FACE="MS Sans Serif, arial,helvetica" size=1 COLOR="#FFFFFF">
                    <b>$html_title: Error: Record(s) Not Deleted</b>
			</td></tr>
			<tr><td>
					<p><center><$font_title><b>
						Error: <font color=red>Record(s) Not Deleted</font>
					</b></font></center><br>
					<$font>
						The records with the following keys were not found in the database: <FONT COLOR="red">'$errstr'</FONT>.
					</font></p>
					|; &html_footer; print qq|
			</td></tr>
		</table>
	</center>	   
</body>
</html>	
|;	
}

##########################################################
##						Modifying						##
##########################################################
sub html_modify_search {
# --------------------------------------------------------
# The page is displayed when a user wants to modify a record. First
# the user has to search the database to pick which record to modify.
# That's handled by this form.

	&html_print_headers;
	print qq|
<html>
<head>
	<title>$html_title: Search the Database for Modifying.</title>
</head>

<body bgcolor="#DDDDDD">
	<form action="$db_script_url" method="GET">
		<input type=hidden name="db" value="$db_setup">
		<input type=hidden name="uid" value="$db_uid">
	
	<center>
		<table border=1 bgcolor="#FFFFFF" cellpadding=5 cellspacing=3 width=500 align=center valign=top>
			<tr><td colspan=2 bgcolor="navy">
					<FONT FACE="MS Sans Serif, arial,helvetica" size=1 COLOR="#FFFFFF">
                    <b>$html_title: Search the Database for Modifying</b>
			</td></tr>
			<tr><td>
					<p><center><$font_title><b>
						Search the Database for Modifying
					</b></font></center><br>
					<$font>
						<P>Search the database for the records you wish to modify or 
						   <A HREF="$db_script_link_url&modify_form=1&$db_key=*">list all</a>:</p>
						|;  &html_record_form(); print qq|
						|; &html_search_options; print qq|</p>
					</font></p>
					<p><center> <INPUT TYPE="SUBMIT" NAME="modify_form" VALUE="Search"> <INPUT TYPE="RESET" VALUE="Reset Form"></center></p>
					|; &html_footer; print qq|
			</td></tr>
		</table>
	</center>	   
	</form>
</body>
</html>		
|;
}


sub html_modify_form {
# --------------------------------------------------------
# The user has searched the database for modification and must now
# pick which record to modify from the records returned. This page
# should produce a radio button with name=modify value=ID for each record.
# We have to do a little work to convert the array @hits that contains
# the search results to a hash for printing.

	my (%tmp);
	my ($status, @hits) = &query("mod");	
	my ($numhits) = ($#hits+1) / ($#db_cols+1);
	if (($numhits == 1) and !$in{'nh'}) { $in{'modify'} = $hits[$db_key_pos]; &html_modify_form_record(); return; }
	my ($maxhits); $in{'mh'} ? ($maxhits = $in{'mh'}) : ($maxhits = $db_max_hits);

	&html_print_headers;
	print qq|
<html>
<head>
	<title>$html_title: Modify Record.</title>
</head>

<body bgcolor="#DDDDDD">
	<form action="$db_script_url" METHOD="POST">
		<input type=hidden name="db" value="$db_setup">
		<input type=hidden name="uid" value="$db_uid">
	<blockquote>
	<table border=1 bgcolor="#FFFFFF" cellpadding=5 cellspacing=3 width=500 valign=top>
		<tr><td colspan=2 bgcolor="navy">
				<FONT FACE="MS Sans Serif, arial,helvetica" size=1 COLOR="#FFFFFF">
                   <b>$html_title: Modify Record</b>
		</td></tr>
	</table>
	<p><$font>
		Check which record you wish to modify and then press "Modify Records":<br>
		Your search returned <b>$db_total_hits</b> matches.</font>
|;
	if ($db_next_hits) {
		print "<br><$font>Pages: $db_next_hits</font>";
	}

# Go through each hit and convert the array to hash and send to 
# html_record for printing. Also add a radio button with name=modify
# and value=key.
	if ($status ne "ok") {	# Error searching database!
		print qq|<P><FONT COLOR="RED" SIZE=4>Error: $status</FONT>|;
	}
	else {
		print "<P>";
		for (0 .. $numhits - 1) {
			%tmp = &array_to_hash($_, @hits);
			print qq|<TABLE BORDER=0><TR><TD><INPUT TYPE=RADIO NAME="modify" VALUE="$tmp{$db_key}"></TD><TD>|;
			&html_record (%tmp);
			print qq|</TD></TR></TABLE>\n|;			
		}
		if ($db_next_hits) {
			print "<br><$font>Pages: $db_next_hits</font>";
		}
	}
	print qq|
		<p>
		<table border=0 bgcolor="#DDDDDD" cellpadding=5 cellspacing=3 width=500 valign=top>
			<tr><td>
				<P><center><input type="SUBMIT" name="modify_form_record" value="Modify Record"> <INPUT TYPE="RESET" VALUE="Reset Form"></center></p>
				|; &html_footer; print qq|
			</td></tr>
		</table>
	</blockquote>
</body>
</html>
|;
}

sub html_modify_form_record {
# --------------------------------------------------------
# The user has picked a record to modify and it should appear
# filled in here stored in %rec. If we can't find the record,
# the user is sent to modify_failure.

	my (%rec) = &get_record($in{'modify'});
	if (!%rec) { &html_modify_failure("unable to find record/no record specified: $in{'modify'}"); return; }

	&html_print_headers;
	print qq|
<html>
<head>
	<title>$html_title: Modify a Record.</title>
</head>

<body bgcolor="#DDDDDD">
	<form action="$db_script_url" method="POST">
		<input type=hidden name="db" value="$db_setup">
		<input type=hidden name="uid" value="$db_uid">	
	<center>
		<table border=1 bgcolor="#FFFFFF" cellpadding=5 cellspacing=3 width=500 align=center valign=top>
			<tr><td colspan=2 bgcolor="navy">
					<FONT FACE="MS Sans Serif, arial,helvetica" size=1 COLOR="#FFFFFF">
                    <b>$html_title: Modify a Record</b>
			</td></tr>
			<tr><td>
					<p><center><$font_title><b>
						Modify a Record
					</b></font></center><br>
					<$font>
						|; &html_record_form (%rec); print qq|
					</font></p>
					<p><center> <INPUT TYPE="SUBMIT" NAME="modify_record" VALUE="Modify Record"> <INPUT TYPE="RESET" VALUE="Reset Form"></center></p>
					|; &html_footer; print qq|
			</td></tr>
		</table>
	</center>	   
	</form>
</body>
</html>	
|;
}

sub html_modify_success {
# --------------------------------------------------------
# The user has successfully modified a record, and this page will 
# display the modified record as a confirmation.

	&html_print_headers;
	print qq|
<html>
<head>
	<title>$html_title: Record Modified.</title>
</head>

<body bgcolor="#DDDDDD">
	<center>
		<table border=1 bgcolor="#FFFFFF" cellpadding=5 cellspacing=3 width=500 align=center valign=top>
			<tr><td colspan=2 bgcolor="navy">
					<FONT FACE="MS Sans Serif, arial,helvetica" size=1 COLOR="#FFFFFF">
                    <b>$html_title: Record Modified.</b>
			</td></tr>
			<tr><td>
					<p><center><$font_title><b>
						Record Modified
					</b></font></center><br>
					<$font>
						The following record was successfully modified:
					</font></p>
					|; &html_record(&get_record($in{$db_key})); print qq|
					|; &html_footer; print qq|
			</td></tr>
		</table>
	</center>	   
</body>
</html>	
|;
}

sub html_modify_failure {
# --------------------------------------------------------
# There was an error modifying the record. $message contains
# the reason why.

	my ($message) = $_[0];
	
	&html_print_headers;
	print qq|
<html>
<head>
	<title>$html_title: Error! Unable to Modify Record.</title>
</head>

<body bgcolor="#DDDDDD">
	<form action="$db_script_url" method="POST">
		<input type=hidden name="db" value="$db_setup">
		<input type=hidden name="uid" value="$db_uid">	
	<center>	
		<table border=1 bgcolor="#FFFFFF" cellpadding=5 cellspacing=3 width=500 align=center valign=top>
			<tr><td colspan=2 bgcolor="navy">
					<FONT FACE="MS Sans Serif, arial,helvetica" size=1 COLOR="#FFFFFF">
                    <b>$html_title: Error! Unable to Modify Record.</b>
			</td></tr>
			<tr><td>
					<p><center><$font_title><b>
						Error: <font color=red>Unable to Modify Record</font>
					</b></font></center><br>
					<$font>
						There were problems modifying the record: <FONT COLOR="red"><B>$message</B></FONT>
						<BR>Please fix any errors and submit the record again.
					</font></p>					
					|; &html_record_form (%in); print qq|
					<p><center> <INPUT TYPE="SUBMIT" NAME="modify_record" VALUE="Modify Record"> <INPUT TYPE="RESET" VALUE="Reset Form"></center></p>
					|; &html_footer; print qq|
			</td></tr>
		</table>
	</center>	   
	</form>
</body>
</html>
|;
}

##########################################################
##						Authentication					##
##########################################################
sub html_login_form {
# --------------------------------------------------------
# The login screen.

	&html_print_headers;
	print qq|
<html>
<head>
	<title>$html_title: Login.</title>
</head>
<body bgcolor="#DDDDDD" text="#000000" onLoad="document.form1.userid.focus()">
	<form action="$db_script_url" method="post" name="form1">
		<input type=hidden name="db" value="$db_setup">
		<input type=hidden name="uid" value="$db_uid">	
	<center>
		<table border=1 bgcolor="#FFFFFF" cellpadding=5 cellspacing=3 width=500 align=center valign=top>
			<tr><td colspan=2 bgcolor="navy">
					<FONT FACE="MS Sans Serif, arial,helvetica" size=1 COLOR="#FFFFFF">
                    <b>$html_title: Login</b>
			</td></tr>
			<tr><td>
					<p><center><$font_title>
					<b>Log On</b></font></center><br>
					<$font>Welcome! You need to have an active account to access $html_title. For
					   the demo, you can use userid/passwords: 'admin/admin', 'author/author', 'guest/guest'.
					<p>
					<table border=0>
					<tr><td><Font face="Verdana, Arial, Helvetica" Size=2 Color=#003399><b>User ID:</b></FONT></td>
						<td><input type="TEXT" name="userid"></td></tr>
					<tr><td><Font face="Verdana, Arial, Helvetica" Size=2 Color=#003399><b>Password:</b></FONT></td>
						<td><input type="PASSWORD" name="pw"></td></tr>
					</table>		
					<p align=center><center><input type="SUBMIT" name="login" value="Logon"> <INPUT TYPE="SUBMIT" NAME="logoff" VALUE="Cancel"></center></p>
			</td></tr>
		</table>
	</center>
	</form>
</body>
</html>
|;
}

sub html_login_failure {
# --------------------------------------------------------
# There was an error loggin in. The error message is stored in $message.

	my ($message) = $_[0];
	
	&html_print_headers;
	print qq|
<html>
<head>
	<title>$html_title: Login Error.</title>
</head>
<body bgcolor="#DDDDDD" text="#000000" onLoad="document.form1.userid.focus()">
	<form action="$db_script_url" method="post" name="form1">
		<input type=hidden name="db" value="$db_setup">
		<input type=hidden name="uid" value="$db_uid">	
	<center>
		<table border=1 bgcolor="#FFFFFF" cellpadding=5 cellspacing=3 width=500 align=center valign=top>
			<tr><td colspan=2 bgcolor="navy">
					<FONT FACE="MS Sans Serif, arial,helvetica" size=1 COLOR=white>
                    <b>$html_title: Login Error</b>
			</td></tr>
			<tr><td>
					<p><center><$font_title>
					<b>Log On Error</b></font></center><br>
					<$font>Oops, there was a problem logging into the system: <font color=red><b>$message</b></font>.<br><br>
					Please try logging in again, or contact the system administrator.</font>
					<p>
					<table border=0>
					<tr><td><Font face="Verdana, Arial, Helvetica" Size=2 Color=#003399><b>User ID:</b></FONT></td>
						<td><input type="TEXT" name="userid" value="$in{'userid'}"></td></tr>
					<tr><td><Font face="Verdana, Arial, Helvetica" Size=2 Color=#003399><b>Password:</b></FONT></td>
						<td><input type="PASSWORD" name="pw" value="$in{'pw'}"></td></tr>
					</table>		
					<p align=center><center><input type="SUBMIT" name="login" value="Logon"> <INPUT TYPE="SUBMIT" NAME="logoff" VALUE="Cancel"></center></p>
			</td></tr>
		</table>
	</center>
	</form>
</body>
</html>
|;
}

sub html_admin_display {
# --------------------------------------------------------
# The displays the list of current users.

	my ($message, $user_list, $password, $permissions) = @_;

	&html_print_headers;
	print qq|
<html>
<head>
	<title>$html_title: User Management.</title>
</head>
<body bgcolor="#DDDDDD" text="#000000">
	<form action="$db_script_url" method="post">
		<input type=hidden name="db" value="$db_setup">
		<input type=hidden name="uid" value="$db_uid">	
		<input type=hidden name="admin_display" value="1">
	<center>
		<table border=1 bgcolor="#FFFFFF" cellpadding=5 cellspacing=3 width=500 align=center valign=top>
			<tr><td colspan=2 bgcolor="navy">
					<FONT FACE="MS Sans Serif, arial,helvetica" size=1 COLOR=white>
                    <b>$html_title: User Management</b>
			</td></tr>
			<tr><td>
				<p><center><$font_title>
				<b>User Management</b></font></center><br>
				
				<p><$font><Font color=red><b>$message</b></font></font></p>
				<table border=0>
				  <tr><td align=right><$font>User List:</font></td>
					  <td>$user_list <input type=submit name=inquire value="Inquire"> <input type=submit name=delete value="Delete"></td></tr>
				  <tr><td align=right><$font>New Username:</font></td>
					  <td><input type="text" name="new_username" size="14"></td></tr>
				  <tr><td align=right><$font>Change Password:</font></td>
					  <td><input type="text" name="password" value="$password" size="14"></td></tr>
				  <tr><td colspan=2><$font>Permissions:
				  					<br>$permissions</font></td></tr>
				</table>
				<P><center><input type=submit value="Update/Create User"></center>
				<P>|; &html_footer; print qq|
			</td></tr>
		</table>
	</center>
	</form>
</body>
</html>
|;
}

sub html_unauth {
# --------------------------------------------------------
# A user tried to do something he was not authorized for.

	&html_print_headers;
	print qq|
<html>
<head>
	<title>$html_title: Error! Unauthorized Action.</title>
</head>

<body bgcolor="#DDDDDD">
	<center>
		<table border=1 bgcolor="#FFFFFF" cellpadding=5 cellspacing=3 width=500 align=center valign=top>
			<tr><td colspan=2 bgcolor="navy">
					<FONT FACE="MS Sans Serif, arial,helvetica" size=1 COLOR="#FFFFFF">
                    <b>$html_title: Error! Unauthorized Action.</b>
			</td></tr>
			<tr><td>
					<p><center><$font_title><b>
						Error: <font color=red>Unauthorized Action</font>
					</b></font></center><br>
					<$font>
						The database program received a command that you are not authorized for.
					</font>
					</p>
					|; &html_footer; print qq|
			</td></tr>
		</table>
	</center>	   
</body>
</html>
|;
}

sub html_signup_form {
# --------------------------------------------------------
# This form is displayed for new users who want to create an account.
#	
	my $error = shift;

	&html_print_headers;
	print qq|
<html>
<head>
	<title>$html_title: Create Account.</title>
</head>
<body bgcolor="#DDDDDD" text="#000000" onLoad="document.form1.userid.focus()">
	<form action="$db_script_url" method="post" name="form1">
		<input type=hidden name="db" value="$db_setup">
		<input type=hidden name="uid" value="$db_uid">	
	<center>
		<table border=1 bgcolor="#FFFFFF" cellpadding=5 cellspacing=3 width=500 align=center valign=top>
			<tr><td colspan=2 bgcolor="navy">
					<FONT FACE="MS Sans Serif, arial,helvetica" size=1 COLOR="#FFFFFF">
                    <b>$html_title: Create Account</b>
			</td></tr>
			<tr><td>
					<p><center><$font_title>
					<b>Create Account</b></font></center><br>
					<$font>To create your own account, simply enter in your desired username and password.
					<p>|; if ($error) { print "<font color=red>$error</font></p>"; } print qq|
					<table border=0>
					<tr><td><Font face="Verdana, Arial, Helvetica" Size=2 Color=#003399><b>User ID:</b></FONT></td>
						<td><input type="TEXT" name="userid" value="$in{'userid'}"></td></tr>
					<tr><td><Font face="Verdana, Arial, Helvetica" Size=2 Color=#003399><b>Password:</b></FONT></td>
						<td><input type="PASSWORD" name="pw" value="$in{'pw'}"></td></tr>
					</table>		
					<p align=center><center><input type="SUBMIT" name="signup" value="Create"> <INPUT TYPE="SUBMIT" NAME="logoff" VALUE="Cancel"></center></p>
			</td></tr>
		</table>
	</center>
	</form>
</body>
</html>
|;
}	

sub html_signup_success {
# --------------------------------------------------------
# The user has successfully created a new account.

	&html_print_headers;
	print qq|
<html>
<head>
	<title>$html_title: Account Created.</title>
</head>
<body bgcolor="#DDDDDD" text="#000000" onLoad="document.form1.userid.focus()">
	<form action="$db_script_url" method="post" name="form1">
		<input type=hidden name="db" value="$db_setup">
		<input type=hidden name="uid" value="$db_uid">	
	<center>
		<table border=1 bgcolor="#FFFFFF" cellpadding=5 cellspacing=3 width=500 align=center valign=top>
			<tr><td colspan=2 bgcolor="navy">
					<FONT FACE="MS Sans Serif, arial,helvetica" size=1 COLOR="#FFFFFF">
                    <b>$html_title: Account Created</b>
			</td></tr>
			<tr><td>
					<p><center><$font_title>
					<b>Account Created</b></font></center><br>
					<$font>Your account has been set up! Use your username and password to log in.
					<p>
					<table border=0>
					<tr><td><Font face="Verdana, Arial, Helvetica" Size=2 Color=#003399><b>User ID:</b></FONT></td>
						<td><input type="TEXT" name="userid"></td></tr>
					<tr><td><Font face="Verdana, Arial, Helvetica" Size=2 Color=#003399><b>Password:</b></FONT></td>
						<td><input type="PASSWORD" name="pw"></td></tr>
					</table>		
					<p align=center><center><input type="SUBMIT" name="login" value="Logon"> <INPUT TYPE="SUBMIT" NAME="logoff" VALUE="Cancel"></center></p>
			</td></tr>
		</table>
	</center>
	</form>
</body>
</html>
|;
}

##########################################################
##						Misc     						##
##########################################################

sub html_unkown_action {
# --------------------------------------------------------
# The program received a command it did not recognize.

	&html_print_headers;
	print qq|
<html>
<head>
	<title>$html_title: Error! Unknown Action.</title>
</head>

<body bgcolor="#DDDDDD">
	<center>
		<table border=1 bgcolor="#FFFFFF" cellpadding=5 cellspacing=3 width=500 align=center valign=top>
			<tr><td colspan=2 bgcolor="navy">
					<FONT FACE="MS Sans Serif, arial,helvetica" size=1 COLOR="#FFFFFF">
                    <b>$html_title: Error! Unkown Action.</b>
			</td></tr>
			<tr><td>
					<p><center><$font_title><b>
						Error: <font color=red>Unknown Action</font>
					</b></font></center><br>
					<$font>
						The database program received a command that it did not understand.
					</font>
					</p>
					|; &html_footer; print qq|
			</td></tr>
		</table>
	</center>	   
</body>
</html>
|;
}

sub html_print_headers {
# --------------------------------------------------------
# Print out the headers if they haven't already been printed.

	if (!$html_headers_printed) {		
		print "Content-type: text/html\n\n";
		$html_headers_printed = 1;
	}
}
1;
