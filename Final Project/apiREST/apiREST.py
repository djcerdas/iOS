#!/usr/bin/python3
"""
    APi REST for the iOS course.
"""
from flask import Flask, request
from flask_restful import Resource, Api


app = Flask(__name__)
api = Api(app)

customers=[]

class Customer(Resource):
  def get(self, id):
    for customer in customers:
      if customer['id'] == id:
        return customer
    return {'ERROR':'Customer is not found.'}, 404

  def post(self, id):
    data = request.get_json() # the payload of the request
    customer = {'id': id, 'name':data['name']}
    customers.append(customer)
    return customer, 201

  def delete(self, id):
    for customer in customers:
      if customer['id'] == id:
        index_customer=customers.index(customer)
        del customers[index_customer]
        return {'Done':"customer was removed."},200
    return {'ERROR':'This customer id does not exist.'}, 404

  def put(self, id):
    data = request.get_json() # the payload of the request
    for customer in customers:
      if customer['id'] == id:
        customer.update(data)
        return customer, 201
    customer = {'id': id, 'name':data['name']}
    customers.append(customer)
    return customer, 201

class Customers(Resource):
  def get(self):
    return customers

api.add_resource(Customer, '/customer/<int:id>') #http://34.121.5.218/customer/<int:id>
api.add_resource(Customers, '/customers') #http://34.121.5.218/customers


app.run(host='0.0.0.0', port=80,debug=True)

