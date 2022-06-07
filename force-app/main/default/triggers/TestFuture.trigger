trigger TestFuture on contact(before insert) {

    Set<Id> accountIds = new Set<Id>();
    System.debug('Trigger RUniing');
    for(contact con: trigger.new)
    {
        accountIds.add(con.accountId);
    }
    FutureTest.countContacts(accountIds);
}