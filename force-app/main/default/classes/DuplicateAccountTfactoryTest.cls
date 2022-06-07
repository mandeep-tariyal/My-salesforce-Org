@isTest
public class DuplicateAccountTfactoryTest {

    @isTest
    public static void DuplicateAccountTest()
    {
       //Adding A dummy account
		list<Account> DummyAcc = new list<Account>();
        DummyAcc.add(new account(name='xyz'));
        DummyAcc.add(new Account(name='xyz1'));
        

        insert DummyAcc;
        
        //test for before insert
        list<Account> AccList = new list<Account>();
        Account acc = new account();
        AccList.add(new account (name = 'xyz'));
        list<Database.SaveResult> resultsForInsert = Database.insert(AccList,false);
        System.debug('Results for Insert ' + resultsForInsert);
        
        //test for After update
        Account AcName = [select name from account where name = :'xyz1'];
        System.debug(AcName.Name);
        AcName.name = 'xyz';
        System.debug('New Name' +AcName.Name);
        Database.saveResult result = database.update(AcName,false);
        System.debug(result + 'Database update error');
        
        
    }
}