class Order {
  int id;    // order ID
  String item;  // ordered item
  int qta;   // quantity of items
  Status status;

  Order(this.id, this.item, this.qta, this.status);
}

// Status of order
// Red: not yet accepted by the pharmacy
// Yellow: pending order (accepted, not yet picked up from pharmacy)
// Green: order completed
enum Status {red, yellow, green}