This file demonstrates how to use the CFC's in the CTCT_Wrapper Library.
Coldfusion version 8,0,1,195765 Developer Edition   
Java Version 1.6.0_04   

For support please visit http://developer.constantcontact.com
To report a bug or suggest improvements, please email WebServices@constantcontact.com

This library is designed so that all functions available are contained in the appropriate collection CFC.
Some functionality also requires a CFC representing an object also be included as an argument, while
other functions do not. For example retrieving all contacts can executed by invoking the getContacts()
method of ContactsCollection.cfc, while other methods such as addContact() require that a Contact.cfc
object be passed into the function [ie: addContact(contactObj)]. Finally Utility.cfc will never be 
directly called on, but is required for all HTTP functionality in this library.

All functions demonstrated are assuming that the ccUsername, ccPassword and apiKey application variables 
are set in Application.cfc. In addition, all examples below assume the following variables have been setup, 
though not all variables are required for each example.

For further documentation please see hints/comments contained in the cfc's themselves.

<cfset ActivitiesCollection = createObject("component", "ActivitiesCollection").init()>
<cfset ContactsCollection = createObject("component", "ContactsCollection").init()>
<cfset CampaignsCollection = createObject("component", "CampaignsCollection").init()>
<cfset LibraryCollection = createObject("component", "LibraryCollection").init()>
<cfset ListsCollection = createObject("component", "ListsCollection").init()>

----------------------------------------------

ContactsCollection

	addContact()

		<cfset contactLists = arrayNew(1)>
		<cfset contactLists[1] = '#application.apiPath#/lists/18'>

		<cfset contactDetails.emailAddress = 'example@example.com'>
		<cfset contactDetails.firstName = 'John'>
		<cfset contactDetails.lastName = 'Doe'>
		<cfset contactDetails.contactLists = contactLists>

		<cfset contactObj = createObject("component", "Contact").init(argumentCollection = contactDetails)>

		<cfset createdContact = ContactsCollection.addContact(contactObj)>


	deleteContact()
		
		<cfset contactsArray = ContactsCollection.getContacts()>
		<cfset contactObj = ContactsCollection.getContactDetails(contactsArray[1][1])>
		<cfset deleteContact = ContactsCollection.deleteContact(contactObj)>

	doesContactExist()

		<cfset contactObj = ContactsCollection.doesContactExist('example@example.com')>

	getContactDetails()

		<cfset contactsArray = ContactsCollection.getContacts()>
		<cfset doesExist = ContactsCollection.getContactDetails(contactsArray[1][1])>

	getContactId()
		
		<cfset contactId = ContactsCollection.getContactId('example@example.com')>

	getContacts()
		
		<cfset contactsArray = ContactsCollection.getContacts()>
		
	removeContact()
		
		<cfset contactsArray = ContactsCollection.getContacts()>
		<cfset contactObj = ContactsCollection.getContactDetails(contactsArray[1][2])>
		<cfset removeContact = ContactsCollection.removeContact(contactObj)>

	searchByEmail()

		<cfset contactObj = ContactsCollection.searchByEmail('djellesma@roving.com')>

	updateContact()

		<cfset contactsArray = ContactsCollection.getContacts()>
		<cfset contactObj = ContactsCollection.getContactDetails(contactsArray[1][1])>
		<cfset contactObj.firstName = 'James'>
		<cfset update = ContactsCollection.updateContact(contactObj)>
		
	
ListsCollection

	addList()

		<cfset listObj = createObject("component", "List").init('My List Name')>
		<cfset listObj = ListsCollection.addList(listObj)>

	deleteList()
		
		<cfset listArray = ListsCollection.getLists()>
		<cfset listObj = ListsCollection.getListDetails(listArray[1][1])>
		<cfset listMembers = ListsCollection.deleteList(listObj)>

	getListDetails()

		<cfset listArray = ListsCollection.getLists()>
		<cfset listObj = ListsCollection.getListDetails(listArray[1][1])>

	getListMembers()

		<cfset listArray = ListsCollection.getLists()>
		<cfset listObj = ListsCollection.getListDetails(listArray[1][1])>
		<cfset listMembers = ListsCollection.getListMembers(listObj)>

	getLists()
		
		<cfset listArray = ListsCollection.getLists()>

	removeListMembers()
		
		<cfset listArray = ListsCollection.getLists()>
		<cfset listObj = ListsCollection.getListDetails(listArray[1][1])>
		<cfset removeActivity = ListsCollection.removeListMembers(listObj)>

	updateList()

		<cfset listArray = ListsCollection.getLists()>
		<cfset listObj = ListsCollection.getListDetails(listArray[1][1])>
		<cfset listObj.sortOrder="55">
		<cfset updateList = ListsCollection.updateList(listObj)>

LibraryCollection

	addFolder()
	
		<cfset folderObj = createObject("component", "Folder").init('My Folder Name')>
		<cfset LibraryCollection.addFolder(folderObj)>
	
	deleteImage()
	
		<cfset foldersArray = LibraryCollection.listFolders()>
		<cfset imagesArray = LibraryCollection.listImagesFromFolder(foldersArray[1][4])>
		<cfset imageDetails = LibraryCollection.getImageDetails(imagesArray[1][1])>
		<cfset deleteImage = LibraryCollection.deleteImage(imageDetails)>
	
	deleteImagesFromFolder()
	
		<cfset foldersArray = LibraryCollection.listFolders()>
		<cfset imagesArray = LibraryCollection.deleteImagesFromFolder(foldersArray[1][1])>
	
	getImageDetails()
	
		<cfset foldersArray = LibraryCollection.listFolders()>
		<cfset imagesArray = LibraryCollection.listImagesFromFolder(foldersArray[1][1])>
		<cfset imageDetails = LibraryCollection.getImageDetails(imagesArray[1][1])>
	
	listFolders()
		
		<cfset foldersArray = LibraryCollection.listFolders()>
	
	listImagesFromFolder()
		
		<cfset foldersArray = LibraryCollection.listFolders()>
		<cfset imagesArray = LibraryCollection.listImagesFromFolder(foldersArray[1][1])>
	
	
CampaignsCollection

	addCampaign()
	
		<cfset campaignObj = createObject("component", "Campaign").init('My Campaign Name')>
		<cfset campaignObj = CampaignsCollection.addCampaign(campaignObj)>
		
	deleteCampaign()
		
		<cfset campaignArray = CampaignsCollection.getCampaigns()>
		<cfset deleteCampaign = CampaignsCollection.deleteCampaign(campaignArray[1][1])>
	
	getCampaigns()
	
		<cfset campaignArray = CampaignsCollection.getCampaigns()>
	
	getCampaignDetails()
		
		<cfset campaignArray = CampaignsCollection.getCampaigns()>
		<cfset campaignObj = CampaignsCollection.getCampaignDetails(campaignArray[1][1])>
	
	searchCampaigns()
	
		<cfset campaignArray = CampaignsCollection.searchCampaigns('SENT')>
	
	updateCampaign()
	
		<cfset campaignArray = CampaignsCollection.getCampaigns()>
		<cfset campaignObj = CampaignsCollection.getCampaignDetails(campaignArray[1][2])>
		<cfset campaignObj.subject = "My New Subject">
		<cfset campaignObj = CampaignsCollection.updateCampaign(campaignObj)>

	
ActivitiesCollection

	bulkExportContacts()
	
		<cfset listid = "#application.apiPath#/lists/18">
		<cfset columns[1] = 'FIRST NAME'>
		<cfset columns[2] = 'LAST NAME'>
		<cfset exportActivity = ActivitiesCollection.bulkExportContacts(columns, listId)>
			
	bulkMultiPart()
	
		<cffile action="read" file="C:\Users\Example\Desktop\example.csv" variable="dataFile"/>
		<cfset myLists = arrayNew(1)>
		<cfset myLists[1] = '#application.apiPath#/lists/18'>
		<cfset bulkActivity = ActivitiesCollection.bulkMultiPart(activityType='SV_ADD', lists=myLists, fileContents=dataFile)>
		
	
	bulkUrlEncoded()
	
		<cfset uploadString = "activityType=SV_ADD&data=Email+Address%2CFirst+Name%2CLast+Name%0A
		wstest3%40example.com%2C+Fred%2C+Test%0A
		wstest4%40example.com%2C+Joan%2C+Test%0A
		wstest5%40example.com%2C+Ann%2C+Test
		&lists=http%3A%2F%2Fapi.constantcontact.com%2Fws%2Fcustomers%2Fjoesflowers%2Flists%2F18">

		<cfset bulkActivity = ActivitiesCollection.bulkUrlEncoded(uploadString)>
	
	clearContactsFromLists()
	
		<cfset myLists = arrayNew(1)>
		<cfset myLists[1] = '#application.apiPath#/lists/18'>
		<cfset myLists[2] = '#application.apiPath#/lists/34'>
		<cfset clearActivity = ActivitiesCollection.clearContactsFromLists(myLists)>	
	
	getActivities()
	
		<cfset activitiesArray = ActivitiesCollection.getActivities()>
	
	getActivityDetails()
	
		<cfset activitiesArray = ActivitiesCollection.getActivities()>
		<cfset activityObj = ActivitiesCollection.getActivityDetails(activitiesArray[1][1])>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	