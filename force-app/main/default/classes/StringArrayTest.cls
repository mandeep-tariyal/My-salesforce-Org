public class  StringArrayTest {
public static void generateStringArray()
	{
        Contact queriedContact = [SELECT Account.Name 
                          FROM Contact limit 1];
        system.debug(queriedContact);

	}
}