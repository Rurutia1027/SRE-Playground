# Extending the Module to Create Public and Private Subnets

## Introduction

In this exercise, we will be extending the module to create both public and private subnets. This process involves
modifying the `subnet_config` variable of our module to accept an optional `public` property for each subnet
configuration and deploying specific resources based on whether there is at least one subnet marked as public. This
hands-on exercise will provide you with a deeper understanding of managing and configuring subnets in AWS.

--- 

## Desired Outcome

If you wise to give it a shot before looking into the detailed step-by-step and the solution videos, here is an overview
of what the created solution should deploy:

- Extend the `subnet_config` module to receive an optional `public` option for each subnet configuration.
- Deploy an `aws_internet_gateway` resource only if there is at least one subnet marked as public.
- Deploy a public `aws_route_table` resource only if there is at least one subnet marked as public.
- Deploy the necessary route table associations for all the public subnets and the public route table.

--- 

## Step-by-Step Guide

- Extend the `subnet_config` variable to receive an optional `public` option for each subnet configuration. The property
  type should be boolean, and default to `false` in case no value is passed.
- In the module, create a new locals block that stores two intermediary local variables:
    - `public_subnets`, which contains the configuration objects only for the subnets with a `public=true` property.