use Supply_chain;
alter table Product add foreign key(SupplierId) references Supplier(Id);
alter table Orders add foreign key  (CustomerId) references Customer(Id);
alter table OrderItem add foreign key(ProductId) references Product(Id);
alter table OrderItem add foreign key(OrderId) references Orders(Id);
