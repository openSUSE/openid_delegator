<% if @identity.errors.any? %>
$('#errors')
  .html('<%=j render(:partial => "shared/errors_explaination", :locals => {:target => @identity}) %>')
  .hide()
  .fadeIn()
<% else %>
$('#errors').hide().fadeOut()
$('#identities')
  .append('<%=j render(:partial => "identity", :locals => {:identity => @identity}) %>')
  .hide()
  .fadeIn()
<% end %>
