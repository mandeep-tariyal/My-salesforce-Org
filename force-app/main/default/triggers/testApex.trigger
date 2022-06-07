trigger testApex on Case (before update) {
    List<String> newNum = new List<String>();
    list<Case> cases =[select id,description from case where caseNumber =:'00001030'];
    newNum.add('00001030');
   
    
    getCase.getCaseDesc(newNum);
	//System.debug('csenumber'+cases[0].description);

}