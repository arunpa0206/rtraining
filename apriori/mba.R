# read data
library(data.table)
aisles <- fread('./input/aisles.csv')
orders <- fread('./input/orders.csv')
department <- fread('./input/departments.csv')
o_p_prior <- fread('./input/order_products__prior.csv')

o_p_train <- fread('./input/order_products__train.csv')
products <- fread('./input/products.csv')

# the products that are reordered
library(dplyr)
library(ggplot2)

reordered_products <- o_p_prior %>%
  left_join(products) %>%
  filter(reordered == 1) %>%
  mutate(product_name <- as.factor(product_name)) %>%
  group_by(product_name) %>%
  summarise(reorder_time=n())

# top 20 products that are reordered
reordered_products %>%
  arrange(desc(reorder_time)) %>%
  slice(1:20) %>%
  ggplot(aes(x=reorder(product_name, reorder_time), y=reorder_time)) +
  geom_bar(fill="blue", stat="identity") +
  labs(title="Top 20 products that are reordered", x="products", y="reorder times") +
  coord_flip()

  # the number of products in each deparment
 product_number_department <- products %>%
  left_join(department) %>%
  mutate(department = as.factor(department)) %>%
  group_by(department) %>%
  summarise(product_number=n())

ggplot(product_number_department, aes(x=reorder(department, product_number), y=product_number)) +
  geom_bar(fill="blue", stat="identity") +
  labs(title="The number of products in each department", x="department", y="product number") +
  coord_flip()


  #average days between a reorder a paticular product
 reordered_interval <- o_p_prior %>%
   full_join(orders) %>%
   left_join(products) %>%
   filter(reordered == 1) %>%
   mutate(product_name <- as.factor(product_name)) %>%
   group_by(product_name) %>%
   summarise(reorder_interval=sum(days_since_prior_order)/n())

 # distribution of average reorder interval
 ggplot(reordered_interval, aes(x=reorder_interval)) +
   geom_histogram()

# shortest reordered 20 products
reordered_interval %>%
  arrange(reorder_interval) %>%
  slice(1:20)
