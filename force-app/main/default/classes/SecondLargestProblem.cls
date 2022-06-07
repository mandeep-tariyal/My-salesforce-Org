public without sharing class SecondLargesProblem{
    public static void getSecondLargestNumber(list<Integer> numbsList)
    {
        Integer largest,secondLargest = 0;
        for(Integer i = 0; i < numbsList.size()-1; i++)
        {
            largest = numbsList[i];
            if(numbsList[i] > largest)
            {
                secondLargest = largest;
                largest = numbsList[i];

                if(i == numbsList.size()-1 && numbsList[numbsList.size()-1] > secondLargest) 
                {
                    secondLargest = numbsList[numbsList.size()-1];
                }
            }
            

        }
    }
}