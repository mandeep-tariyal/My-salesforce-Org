@isTest
public class filterDuplicatesTest {
	@isTest
    public static void checkDuplicates()
    {
    //adding a dummmy record
    
        List<Account> accounts = new List<Account>();
    	accounts.add(new account(name='xyz'));
   		accounts.add(new account(name='xyz1'));
    
    	insert accounts;
        system.debug('inserted'+accounts);
    
        //pushing list of account (one with same name)
   		list<Account> accList = new List<Account>();
        System.debug('pushing list of accounts   with same name');
    	accList.add(new account(name = 'xyz'));
    	accList.add(new account(name = 'yz'));
    	list<Database.SaveResult> resultsForInsert = database.insert(accList,false);
        
        System.debug('Results for Insert ' + resultsForInsert);
        
        
        //Fetching account with a different name and updating it to existing account name
        Account  acName = [select name from account where name =:'xyz1'];
        acName.Name = 'xyz';
        database.SaveResult resultForUpdate = database.update(acName,false);
        System.Debug('For Update' +resultForUpdate);
        
       
        
	}
}