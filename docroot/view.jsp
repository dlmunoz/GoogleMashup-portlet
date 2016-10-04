<%
/**
 * Copyright (c) 2000-2013 Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */
%>

<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>
<%@ taglib uri="http://alloy.liferay.com/tld/aui" prefix="aui" %>

<portlet:defineObjects />

<form action='<liferay-portlet:actionURL portletConfiguration="true" />' method="post" name="<portlet:namespace />fm">
    <aui:input name="origin" label="Origen" />
    <aui:input name="destination" label="Destino" />
    <aui:input name="journeyDate" label="Fecha del viaje" value=" "  id="inputDisplay" />
    <div class="calendar-icon" id="<portlet:namespace />imageDiv">
        <span class="aui-icon aui-icon-calendar"></span>
	</div>
	<div id="<portlet:namespace />calendarDiv"></div>
    <aui:input name="duration" label="Duración" suffix="(en días)" />
    <input type="button" value="Buscar" onclick="<portlet:namespace />postPlanDetails()" />
</form>


<aui:script>


renderCalendar('#<portlet:namespace />imageDiv','#<portlet:namespace/>inputDisplay','#<portlet:namespace />calendarDiv'); 	
function renderCalendar(imageDiv,inputDisplay,calendarDiv)  {
	   /*alert(imageDiv);
	  alert(inputDisplay);
	  alert(calendarDiv);*/
	  
	  var rules = {
			  "all": {
			    "all": {
			      "all": {
			        "0,6": "all-weekends"
			      }
			    }
			  }
			};
	  
	  AUI().ready('aui-calendar', function(A) {
	    var inputField1 = A.one(imageDiv);
	    var inputField2 = A.one(inputDisplay);
	   

	    var calendar1 = new A.Calendar({   
	        dates: [ new Date() ],   
	        dateFormat: '%d-%m-%Y',    
	        selectMultipleDates: false,
	        showPrevMonth: false,
	    	showNextMonth:true,
	        after: {                        
	            datesChange: function(event) {         
	                        var formatted = event.target.getFormattedSelectedDates();
	                        alert(inputField2);
	                        inputField2.val(formatted);
	                        calendar1.toggle(); // hide after a date was selected       
	                    }       
	                }
	    });
	   // }).render(calendarDiv);
	    calendar1.set("disabledDatesRule", rules);
	    calendar1.render(calendarDiv);
	    //calendar1.set("disabledDatesRule", rules);

	    var boundingBoxCal1 = calendar1.get('boundingBox'); 
	    boundingBoxCal1.setX(inputField1.getX());         
	    boundingBoxCal1.setY(inputField1.getY() + 25);      
	    calendar1.hide();
	    inputField1.on('click', function() { calendar1.toggle(); });       
	});
	}

/* AUI().ready('aui-calendar', function(A) {
	
    var calendar = new A.Calendar({
       
        trigger : '#<portlet:namespace />journeyDate',
        dates: ['09/15/2009'],
        dateFormat : '%d/%m/%Y',
        setValue : true,
        selectMultipleDates : false
}).render();
 
});  */



function <portlet:namespace />postPlanDetails() {
    var origin = document.<portlet:namespace />fm.<portlet:namespace />origin.value;
    var dest = document.<portlet:namespace />fm.<portlet:namespace />destination.value;
    var journeyDate = document.<portlet:namespace />fm.<portlet:namespace />journeyDate.value;
    var duration = document.<portlet:namespace />fm.<portlet:namespace />duration.value;
 
    Liferay.fire('planTravel', {
        origin : origin,
        destination : dest,
        journeyDate : journeyDate,
        duration : duration
    });
 
}


Liferay.on('directionsChanged',
	    function(event) {
	        document.<portlet:namespace />fm.<portlet:namespace />origin.value = event.origin;
	        document.<portlet:namespace />fm.<portlet:namespace />destination.value = event.destination;
	});

</aui:script>
