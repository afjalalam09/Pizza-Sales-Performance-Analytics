import streamlit as st
import pandas as pd
import plotly.express as px

# 1. Page Configuration
st.set_page_config(page_title="Pizza Sales Dashboard", page_icon="🍕", layout="wide")
st.title("🍕 Pizza Sales Performance Analytics")
st.markdown("Interactive Web App built with Python & Streamlit")

# 2. Load Data
@st.cache_data
def load_data():
    # Make sure your CSV file name exactly matches here
    df = pd.read_csv("pizza_sales.csv") 
    return df

df = load_data()

# 3. Calculate KPIs
total_revenue = df['total_price'].sum()
total_orders = df['order_id'].nunique()
total_pizzas = df['quantity'].sum()
avg_order_value = total_revenue / total_orders
avg_pizzas_per_order = total_pizzas / total_orders

# 4. Display KPIs
st.markdown("### 📊 High-Level Metrics")
col1, col2, col3, col4, col5 = st.columns(5)
col1.metric("Total Revenue", f"${total_revenue:,.2f}")
col2.metric("Avg Order Value", f"${avg_order_value:.2f}")
col3.metric("Total Pizzas Sold", f"{total_pizzas:,}")
col4.metric("Total Orders", f"{total_orders:,}")
col5.metric("Avg Pizzas/Order", f"{avg_pizzas_per_order:.2f}")

st.markdown("---")

# 5. Charts (Row 1)
col_a, col_b = st.columns(2)

with col_a:
    st.markdown("### 🏆 Top 5 Pizzas by Revenue")
    top_revenue = df.groupby('pizza_name')['total_price'].sum().reset_index().sort_values(by='total_price', ascending=False).head(5)
    fig_rev = px.bar(top_revenue, x='total_price', y='pizza_name', orientation='h', color_discrete_sequence=['#1f77b4'])
    fig_rev.update_layout(yaxis={'categoryorder':'total ascending'})
    st.plotly_chart(fig_rev, use_container_width=True)

with col_b:
    st.markdown("### 🍕 % Sales by Pizza Category")
    cat_sales = df.groupby('pizza_category')['total_price'].sum().reset_index()
    fig_cat = px.pie(cat_sales, values='total_price', names='pizza_category', hole=0.4)
    st.plotly_chart(fig_cat, use_container_width=True)
