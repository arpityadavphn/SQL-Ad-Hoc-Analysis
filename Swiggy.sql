1. HOW MANY RESTAURANTS HAVE A RATING GREATER THAN 4.5?

	SELECT COUNT(*) AS number_of_restaurants
	FROM swiggydb
	WHERE RATING>4.5
	

2. WHICH IS THE TOP 1 CITY WITH THE HIGHEST NUMBER OF RESTAURANTS?

	SELECT city AS city_name,
	COUNT(*) AS count
	FROM swiggydb
	GROUP BY city
	ORDER BY count DESC
	LIMIT 1


3. HOW MANY RESTAURANTS HAVE THE WORD "PIZZA" IN THEIR NAME?

	SELECT COUNT(*) AS total_pizza_restaurants
	FROM swiggydb
	WHERE restaurant_name LIKE '%Pizza%';

4. WHAT IS THE MOST COMMON CUISINE AMONG THE RESTAURANTS IN THE DATASET?

	SELECT cuisine AS name_of_cuisine
	FROM swiggydb
	GROUP BY cuisine
	ORDER BY COUNT(*) DESC
	LIMIT 1


5. WHAT IS THE AVERAGE RATING OF RESTAURANTS IN EACH CITY?

	SELECT city AS name_of_city,
	ROUND(AVG(rating),2) AS avg_rating
	FROM swiggydb
	GROUP BY city

6. WHAT IS THE HIGHEST PRICE OF ITEM UNDER THE 'RECOMMENDED' MENUCATEGORY FOR EACH RESTAURANT?

	SELECT DISTINCT
	restaurant_name AS name_of_restaurant,
	MAX(PRICE) OVER(PARTITION BY restaurant_name) AS max_price
	FROM swiggydb
	WHERE menu_category = 'RECOMMENDED'

		(OR)
	
	SELECT 
		restaurant_name AS name_of_restaurant,
		MAX(price) AS max_price
	FROM swiggydb
	WHERE menu_category = 'RECOMMENDED'
	GROUP BY restaurant_name;

7. FIND THE TOP 5 MOST EXPENSIVE RESTAURANTS THAT OFFER CUISINE OTHER THAN INDIAN CUISINE.
	
	SELECT DISTINCT restaurant_name AS name_of_restaurant, price
	FROM swiggydb
	WHERE cuisine <> 'indian'
	ORDER BY price DESC
	LIMIT 5
	
8. FIND THE RESTAURANTS THAT HAVE AN AVERAGE COST WHICH IS HIGHER THAN THE TOTAL AVERAGE COST OF ALL RESTAURANTS TOGETHER.

	SELECT restaurant_name, cost_per_person
	FROM swiggydb
	GROUP BY restaurant_name, cost_per_person
	HAVING cost_per_person> (SELECT AVG(cost_per_person) FROM swiggydb)

9. RETRIEVE THE DETAILS OF RESTAURANTS THAT HAVE THE SAME NAME BUT ARE LOCATED IN DIFFERENT CITIES.

	SELECT DISTINCT s2.restaurant_name as restaurant_name
	FROM swiggydb AS s1
	JOIN swiggydb AS s2
	ON s1.restaurant_name = s2.restaurant_name
	and s1.city<>s2.city


10. WHICH RESTAURANT OFFERS THE MOST NUMBER OF ITEMS IN THE 'MAIN COURSE'CATEGORY

	SELECT restaurant_name,
	COUNT(menu_category) AS number_of_items
	FROM swiggydb
	WHERE menu_category = 'MAIN COURSE'
	GROUP BY restaurant_name
	ORDER BY number_of_items DESC
	LIMIT 1

11. LIST THE NAMES OF RESTAURANTS THAT ARE 100% VEGEATARIAN IN ALPHABETICAL ORDER OF RESTAURANT NAME.

	SELECT DISTINCT restaurant_name

	FROM swiggydb
	WHERE restaurant_no NOT IN
			(SELECT DISTINCT restaurant_no
			FROM swiggydb
			WHERE `veg_or_non-veg` = 'NON-VEG')

	ORDER BY restaurant_name

12. WHICH IS THE RESTAURANT PROVIDING THE LOWEST AVERAGE PRICE FOR ALL ITEMS?

	SELECT restaurant_name,AVG(price) AS avg_price
	FROM swiggydb
	GROUP BY restaurant_name
	ORDER BY avg_price ASC
	LIMIT 1

13. WHICH TOP 5 RESTAURANT OFFERS HIGHEST NUMBER OF CATEGORIES?

	SELECT 
		restaurant_name, COUNT(menu_category) AS total_categories
	FROM swiggydb
	GROUP BY restaurant_name
	ORDER BY total_categories DESC
	LIMIT 5

14. WHICH RESTAURANT PROVIDES THE HIGHEST PERCENTAGE OF NON-VEGEATARIAN FOOD?

	SELECT 
		restaurant_name, COUNT(`veg_or_non-veg`) AS total
	FROM swiggydb
	WHERE `veg_or_non-veg` = 'non-veg'
	GROUP BY restaurant_name
	ORDER BY total DESC
	LIMIT 1
